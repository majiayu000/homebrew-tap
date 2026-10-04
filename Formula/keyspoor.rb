class Keyspoor < Formula
  desc "Secret scanner with redacted output and agent-friendly interfaces"
  homepage "https://github.com/majiayu000/keyspoor"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.3/keyspoor-v0.1.3-x86_64-apple-darwin"
      sha256 "d94a26bc3bcd03b08669aec2d6ab02b42a9692b83fe139c14457f05dbd5e53e8"
    end
    on_arm do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.3/keyspoor-v0.1.3-aarch64-apple-darwin"
      sha256 "6a46b5ded3b0c6d3f16bfdea05b46bd28639a95353aad6858dbb450265226ab8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.3/keyspoor-v0.1.3-x86_64-unknown-linux-gnu"
      sha256 "7105fb2a045f4efba00bb5daa5bbc554bf4f65eb9abe167d7e20b0c2620de32c"
    end
    on_arm do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.3/keyspoor-v0.1.3-aarch64-unknown-linux-gnu"
      sha256 "bcb59454ec13bcb86a6d36b5ab6b328a482869387a67ec49c48fc73a07efa8d6"
    end
  end

  resource "LICENSE" do
    url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.3/LICENSE"
    sha256 "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30"
  end

  resource "THIRD_PARTY_NOTICES" do
    url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.3/THIRD_PARTY_NOTICES"
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
