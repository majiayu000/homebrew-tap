# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.86"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.86/remem-darwin-x64.tar.gz"
      sha256 "4d9c3fe8b02d85aaebb87c604a50a6bd0bb23a57fa57cc194720bef2f12f308f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.86/remem-darwin-arm64.tar.gz"
      sha256 "a1ebf7030d1914ca2433e0cf1e6a6e05af75e7cb49a4291ae72de3fe76d47949"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.86/remem-linux-x64.tar.gz"
      sha256 "b1fe5e3bf544c16e0fc9490a1a19d1adc078ba94dc68c3d3905a0c6dcdb10559"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.86/remem-linux-arm64.tar.gz"
      sha256 "019d9b3445f413f399e838bab75332d423912ec0a25b4ba0be02bad3fdb852bd"
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
    assert_match "remem 0.6.86", shell_output("#{bin}/remem --version")
  end
end
