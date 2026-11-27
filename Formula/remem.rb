# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.7.15"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.15/remem-darwin-x64.tar.gz"
      sha256 "906109cba2677cce4d134b874c525c55d7ca2ba7fd06a5374fd91805baa9b301"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.15/remem-darwin-arm64.tar.gz"
      sha256 "d3f7e1b1730def0e75901ed84058f2008f91df2cc764dd3ee42176e01abf5c5c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.15/remem-linux-x64.tar.gz"
      sha256 "ac1ff1ed5e992b349abaf56b80cb5c94faf4a094b1f888a99c6b945e24ff682d"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.15/remem-linux-arm64.tar.gz"
      sha256 "71df0b2890621fa3480d68b9c3186a1a200a723795821b2f1de34609e6e3e0b1"
    end
  end

  def install
    bin.install "remem" => "remem"
    if OS.mac? && Hardware::CPU.arm?
      unless quiet_system "codesign", "--verify", bin/"remem"
        system "codesign", "--force", "--sign", "-", bin/"remem"
      end
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
    assert_match "remem 0.7.15", shell_output("#{bin}/remem --version")
  end
end
