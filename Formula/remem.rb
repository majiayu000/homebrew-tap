# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.55"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.55/remem-darwin-x64.tar.gz"
      sha256 "b011a80201c597b81d52b58726e43c1d88f48386dd847c9c8497d0b5f81f6122"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.55/remem-darwin-arm64.tar.gz"
      sha256 "e8dfc1dd78b141485021ec8c5d83a05a8e338c99afcd400951822243ce2321d0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.55/remem-linux-x64.tar.gz"
      sha256 "deac140bfeaa5f44b914a3b6b9942863c4028441d317d31c1a82c3a66fe33bd5"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.55/remem-linux-arm64.tar.gz"
      sha256 "3521c4730112b46bebf47891a959218fd0db1aae4991a17ac1155d5217b551c3"
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
    assert_match "remem 0.6.55", shell_output("#{bin}/remem --version")
  end
end
