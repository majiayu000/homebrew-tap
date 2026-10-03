class Keyspoor < Formula
  desc "Secret scanner with redacted output and agent-friendly interfaces"
  homepage "https://github.com/majiayu000/keyspoor"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.1/keyspoor-v0.1.1-x86_64-apple-darwin"
      sha256 "ab0a6d3fe727e912ddbe97b3f8fc14d942619990cf05a4d7c4b2a5efad054a04"
    end
    on_arm do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.1/keyspoor-v0.1.1-aarch64-apple-darwin"
      sha256 "b4c128f2ee52894786c1a1a7fe1d4480ca02e403e153115057a68bee6b0ca0b1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.1/keyspoor-v0.1.1-x86_64-unknown-linux-gnu"
      sha256 "fba89f6da6a2d435c9bde21f84e5225461ee831a95003a4eeb496efbd66d3c37"
    end
    on_arm do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.1/keyspoor-v0.1.1-aarch64-unknown-linux-gnu"
      sha256 "458c70dee7217da8350a9b215c416ca30d3090bffd7a08b3c802cd53bc9cb6f9"
    end
  end

  resource "LICENSE" do
    url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.1/LICENSE"
    sha256 "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30"
  end

  resource "THIRD_PARTY_NOTICES" do
    url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.1/THIRD_PARTY_NOTICES"
    sha256 "2384b40f9fb846b77ac0dc07b66092973c82cbbe708cb2e451a7c975def7f605"
  end

  def install
    bin.install File.basename(stable.url) => "keyspoor"
    resource("LICENSE").stage { prefix.install "LICENSE" }
    resource("THIRD_PARTY_NOTICES").stage { prefix.install "THIRD_PARTY_NOTICES" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/keyspoor --version")
    (testpath/"clean.txt").write "nothing sensitive here\n"
    clean = JSON.parse(shell_output("#{bin}/keyspoor scan #{testpath}/clean.txt"))
    assert_empty clean.fetch("findings")
    token = "ghp_" + "9Zb2Ef7hIj4kLm6nOp8qRs0tUv3wXy5zAbCd"
    (testpath/"secret.txt").write "token=#{token}\n"
    output = shell_output("#{bin}/keyspoor scan #{testpath}/secret.txt", 1)
    refute_empty JSON.parse(output).fetch("findings")
    refute_match token, output
  end
end
