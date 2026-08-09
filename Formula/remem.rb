# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.61"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.61/remem-darwin-x64.tar.gz"
      sha256 "72e712fd6619f857fe7752c01514ebf1a36668bd430979fc6ba5b897b993b452"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.61/remem-darwin-arm64.tar.gz"
      sha256 "fe3f035505a01c516dbd6b1b96a2a515872c3937ef13090443acc68ba63b377f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.61/remem-linux-x64.tar.gz"
      sha256 "f22ac6389d60a44f95d9ccabd5cc114fef2143618cdc9364349fdd9cd73d1b8c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.61/remem-linux-arm64.tar.gz"
      sha256 "7ab52aa3bc930d98772a7d81ba98b513efdff38d15bf0f5b5bd43430e47118c8"
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
    assert_match "remem 0.6.61", shell_output("#{bin}/remem --version")
  end
end
