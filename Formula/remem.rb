# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.43"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.43/remem-darwin-x64.tar.gz"
      sha256 "46c166844c2f0e49dbe292e12cf99829db30783e5670750524731a363589f503"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.43/remem-darwin-arm64.tar.gz"
      sha256 "3fa5762f369c0fa2f4c638f45fb0f426ad4c0d5a842113812a135e76969a0968"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.43/remem-linux-x64.tar.gz"
      sha256 "ebe82d58cf5c816d882c4ff2ac128cd1a3a8efcf7d473bdb0d9db6ad3168aa04"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.43/remem-linux-arm64.tar.gz"
      sha256 "4d98d281c65f0a7c9d26509b262e0b528eb1666aafb89088589469bed38c0c45"
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
    assert_match "remem 0.6.43", shell_output("#{bin}/remem --version")
  end
end
