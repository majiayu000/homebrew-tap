# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.71"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.71/remem-darwin-x64.tar.gz"
      sha256 "d84bd507fcfeaae69397a150aa6b637cd30b7c86cfc3071af8d3017ea1880bbc"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.71/remem-darwin-arm64.tar.gz"
      sha256 "b1a69fb68d87ad9c7fdca9a3bd03007b9d06511110e41a7e07175b9b79bd36da"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.71/remem-linux-x64.tar.gz"
      sha256 "4e6a37420b1c257e3d91eae8032eb004ef10ac35350ad0a5de73a1de3daba644"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.71/remem-linux-arm64.tar.gz"
      sha256 "0eb4f6460e9d64731880ee81988100cefec242685a24a1a1589d7138c23ee5e9"
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
    assert_match "remem 0.6.71", shell_output("#{bin}/remem --version")
  end
end
