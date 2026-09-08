# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.92"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.92/remem-darwin-x64.tar.gz"
      sha256 "cf6e482f99533c0523fee3f1d1cb6ec510b1542e58cdd20f676d620eb1a55685"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.92/remem-darwin-arm64.tar.gz"
      sha256 "9caefdb1a87b63cdf2b6902fcae98c23e04f56735fe9edc8707b0edf2773485b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.92/remem-linux-x64.tar.gz"
      sha256 "4491511179a3f528efbe2ee1d688a84ea2246ac9e2d3b27e1eacf299390a9a73"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.92/remem-linux-arm64.tar.gz"
      sha256 "6506970302b8c0897ee10a52102a5d664101b35a7f3a8d6e500d683c364b1bb4"
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
    assert_match "remem 0.6.92", shell_output("#{bin}/remem --version")
  end
end
