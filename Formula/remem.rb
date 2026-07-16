# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.213"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.213/remem-darwin-x64.tar.gz"
      sha256 "cdd8cf8e78f4f78b3c0d66a3f31c74750728a59f0c0c3d7ee1fedd273f98f97e"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.213/remem-darwin-arm64.tar.gz"
      sha256 "2c01e4b565e6b2603b1a84b79b12cf7e4f9c057a3a46c13c3d5047dcb6c76a71"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.213/remem-linux-x64.tar.gz"
      sha256 "5ee5ea5364e098a9c253af29c52fe6d4cadf60d7e7bebce3f527dad19b8ad51b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.213/remem-linux-arm64.tar.gz"
      sha256 "bc7996c180109703c9a852fc4ba1bc37003b733882e070ac9df97f8e95cdd79d"
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
    assert_match "remem 0.5.213", shell_output("#{bin}/remem --version")
  end
end
