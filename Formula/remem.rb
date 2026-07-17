# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.1/remem-darwin-x64.tar.gz"
      sha256 "e11ea45ec39e05e0c2d96c5c51b00903d57bc82876642c623c96ae880dc00f84"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.1/remem-darwin-arm64.tar.gz"
      sha256 "685b8540cc319fc478b622d829a637657b43d2aca7d570a6d3c3cf3cc4f8f8c9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.1/remem-linux-x64.tar.gz"
      sha256 "b82111a974dd18cf94ffb7be7098ff31e8d76afc05e40e1c6ea82203d70bae2c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.1/remem-linux-arm64.tar.gz"
      sha256 "d58018f03d95aff92755656448977316ddc946c783587b92520898f4a703309e"
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
    assert_match "remem 0.6.1", shell_output("#{bin}/remem --version")
  end
end
