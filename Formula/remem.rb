# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.30"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.30/remem-darwin-x64.tar.gz"
      sha256 "6c2b325bfca536cbb6b7fd5fae43a68e0847a3735efe80a8b7ec96db2a1542eb"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.30/remem-darwin-arm64.tar.gz"
      sha256 "41017ab5dc487121229bb75b0a849243f189bd7a8ec9f3cb100e44aa1646bd40"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.30/remem-linux-x64.tar.gz"
      sha256 "81dbf117f2455f06dfd5963807bf3ba9fca17003a0f2b272ae1c3b86a1342a32"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.30/remem-linux-arm64.tar.gz"
      sha256 "de667e1e052e7d1fab67637b75d7b860554515883cf4cec5bb869bf391c83aa2"
    end
  end

  def install
    bin.install "remem" => "remem"
    if OS.mac? && Hardware::CPU.arm?
      system "codesign", "--force", "--sign", "-", bin/"remem"
    end
  end

  def caveats
    <<~EOS
      Finish agent integration after installing the binary by choosing
      the agent configuration to create:

        REMEM_INSTALL_BINARY=#{opt_bin}/remem remem install --target codex
        REMEM_INSTALL_BINARY=#{opt_bin}/remem remem install --target claude
        REMEM_INSTALL_BINARY=#{opt_bin}/remem remem install --target all

      If Claude Code or Codex CLI config directories already exist,
      auto-detection is also available:

        REMEM_INSTALL_BINARY=#{opt_bin}/remem remem install

      Run remem doctor to verify or troubleshoot the integration.
    EOS
  end

  test do
    assert_match "remem 0.6.30", shell_output("#{bin}/remem --version")
  end
end
