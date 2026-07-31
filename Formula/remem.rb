# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.41"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.41/remem-darwin-x64.tar.gz"
      sha256 "7d8e0b2ec9bbd27e962b2368e7febe111914b69fc5620fd3fe3de7ddba24bcbd"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.41/remem-darwin-arm64.tar.gz"
      sha256 "2db9313614e5e01b01b1888bffd9da8817d37638c457be0dfdd255464a6d5542"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.41/remem-linux-x64.tar.gz"
      sha256 "2f2cc52f55153f37bd63aa4b2a194dac65d0942c4987c0efb86ae1311689efb3"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.41/remem-linux-arm64.tar.gz"
      sha256 "cedc785e7cfd65b740d08c2077578b28513e74161291dd6cd4df7d1f43086859"
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
    assert_match "remem 0.6.41", shell_output("#{bin}/remem --version")
  end
end
