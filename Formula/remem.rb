# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.2/remem-darwin-x64.tar.gz"
      sha256 "12549f786008f51a5aacb796a9966d80e91e568cd736fff3e45e52f04f5573bc"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.2/remem-darwin-arm64.tar.gz"
      sha256 "dde0369fb9eb033b8eeea68de497a8ed19a6c38db97d8326d64ee3e61119cccb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.2/remem-linux-x64.tar.gz"
      sha256 "bc7f88bfcdaf593e29b54afd2d936a7bf60e797ae517b4547a41cc79485d06e9"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.2/remem-linux-arm64.tar.gz"
      sha256 "40d56e2330513e7c05a3d1faf5c7d2763670c2e8c09f008a75b1993ec95d9c97"
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
    assert_match "remem 0.6.2", shell_output("#{bin}/remem --version")
  end
end
