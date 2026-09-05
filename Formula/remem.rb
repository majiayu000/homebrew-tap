# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.87"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.87/remem-darwin-x64.tar.gz"
      sha256 "4b7d5b3649056a12c1639c11187fb3d677878b8e6ab4a06af0af6cfba560cd6b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.87/remem-darwin-arm64.tar.gz"
      sha256 "c784da9893aea28cdbfc3446260d1e765054047f08886642899830067d8c776b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.87/remem-linux-x64.tar.gz"
      sha256 "613e7855c8a48fae43033f412ede37c678457febf8ff4b4cb978fc6bccb22799"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.87/remem-linux-arm64.tar.gz"
      sha256 "30aafeeaa9dd9d975ffaa6514abca8c13ae5507790500358678bba8f5f59d617"
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
    assert_match "remem 0.6.87", shell_output("#{bin}/remem --version")
  end
end
