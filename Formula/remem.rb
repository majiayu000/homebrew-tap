# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.11"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.11/remem-darwin-x64.tar.gz"
      sha256 "8f500efddacf9db65cd882ecce9230f037a0fef9f2af46a3e3f7ea1917901eb0"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.11/remem-darwin-arm64.tar.gz"
      sha256 "7d2b53decaa1c37c11d9c18aa72c9e9acb8f92e18f88db9b2f534147f0fbf794"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.11/remem-linux-x64.tar.gz"
      sha256 "680062a55b539c697567bb51dca5e21c08ca6a6e3aa11ff94d1e84dabb924a55"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.11/remem-linux-arm64.tar.gz"
      sha256 "3eb53700c2bb028f4c2a829e1ee6a7bb56e1252e3e2166154c569ed8cae1598c"
    end
  end

  def install
    bin.install "remem"
  end

  test do
    assert_match "remem 0.5.11", shell_output("#{bin}/remem --version")
  end
end
