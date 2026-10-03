class Keyspoor < Formula
  desc "Secret scanner with redacted output and agent-friendly interfaces"
  homepage "https://github.com/majiayu000/keyspoor"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.2/keyspoor-v0.1.2-x86_64-apple-darwin"
      sha256 "bed3ad9cacb20bdf8dfc701770dd0715f18bf0a25641269e4804e03137928225"
    end
    on_arm do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.2/keyspoor-v0.1.2-aarch64-apple-darwin"
      sha256 "1e65ffd9eaf3aa06d90aaf689120a386d944c231cb053738145d5a1aeba57ced"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.2/keyspoor-v0.1.2-x86_64-unknown-linux-gnu"
      sha256 "bfc0d5872c944c1e2fd79bba6f27b2cfecb59858546a406df5ddbd1fae1337c9"
    end
    on_arm do
      url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.2/keyspoor-v0.1.2-aarch64-unknown-linux-gnu"
      sha256 "b9b5323999ea2919280f513284ee0e030032857f2bb682e83cfcbb449cc87bdc"
    end
  end

  resource "LICENSE" do
    url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.2/LICENSE"
    sha256 "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30"
  end

  resource "THIRD_PARTY_NOTICES" do
    url "https://github.com/majiayu000/keyspoor/releases/download/v0.1.2/THIRD_PARTY_NOTICES"
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
