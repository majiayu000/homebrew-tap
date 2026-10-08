class Keyspoor < Formula
  desc "Secret scanner with redacted output and agent-friendly interfaces"
  homepage "https://github.com/majiayu000/keyspoor"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.4/keyspoor-v0.1.4-x86_64-apple-darwin"
      sha256 "1c863f4dc3114c14ece677f8b7cd68475b88265b7ac4afe44fea1c76e6c3d09d"
    end
    on_arm do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.4/keyspoor-v0.1.4-aarch64-apple-darwin"
      sha256 "be720e8c820f70630d904d70f82256bcefdacf4ef734a83d498555b43e2d12a4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.4/keyspoor-v0.1.4-x86_64-unknown-linux-gnu"
      sha256 "de4018b1bfc3cc8515a7d19067b02e6cff95568705a5a1ac81b1a0046cf9ebaf"
    end
    on_arm do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.4/keyspoor-v0.1.4-aarch64-unknown-linux-gnu"
      sha256 "f39fcd28515e6b2243de4398612d7768ba2d7a3861f70b91b052f41d2c6a592e"
    end
  end

  resource "LICENSE" do
    url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.4/LICENSE"
    sha256 "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30"
  end

  resource "THIRD_PARTY_NOTICES" do
    url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.4/THIRD_PARTY_NOTICES"
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
