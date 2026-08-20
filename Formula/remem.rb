# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.81"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.81/remem-darwin-x64.tar.gz"
      sha256 "3b9b0249e62028fb1326112f5c6f39918c40a5d86e0e9eed28e6c537e4e4108b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.81/remem-darwin-arm64.tar.gz"
      sha256 "2d7ceaa80d27e0d8ee63d34f6ea0322621aa6d7a332a09938365db32d42ba45e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.81/remem-linux-x64.tar.gz"
      sha256 "6b9e5f7c20898ac0f53b0df02ffd863be62d8eb5c5f756efe91f54d896829758"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.81/remem-linux-arm64.tar.gz"
      sha256 "dabf0c8e8e273d5c1b697eebcae9cee54030fdb0b363547d0e70dbafa8ae9b5f"
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
    assert_match "remem 0.6.81", shell_output("#{bin}/remem --version")
  end
end
