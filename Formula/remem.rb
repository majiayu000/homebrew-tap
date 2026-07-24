# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.24"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.24/remem-darwin-x64.tar.gz"
      sha256 "e7c5cabb6ea0e75818acd5c6dd5538af91110e7f67927af31f1c286c22e1141b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.24/remem-darwin-arm64.tar.gz"
      sha256 "82f8a770eae6ebdf097050403d2e087821f4aacf63bb94e0b330da01d6528c0f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.24/remem-linux-x64.tar.gz"
      sha256 "c6b39bb7cc3be8681b7dce6ec1e97a17c4186ce2b99e12482b0ca720aba6a025"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.24/remem-linux-arm64.tar.gz"
      sha256 "1adad34525886281c94c461ae6c6143b3fab87eee4d5078fc7def989a5d12997"
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
    assert_match "remem 0.6.24", shell_output("#{bin}/remem --version")
  end
end
