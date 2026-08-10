# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.67"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.67/remem-darwin-x64.tar.gz"
      sha256 "6bb20a8840f97211fe9797f84032866900acc18dfaa1288c09c6316539c206e0"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.67/remem-darwin-arm64.tar.gz"
      sha256 "38f9135e2c0a47b7a7942a7036b647e5bbeaad69017e0bac298081b025aec28b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.67/remem-linux-x64.tar.gz"
      sha256 "be4d4e32bfa0e0e853356543ad854bc0edda40fe9c00097b4440ccc1585d9869"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.67/remem-linux-arm64.tar.gz"
      sha256 "47b977bc32062068d37810fd7db0d2034386d718e2de563f609e2b71715cb5cd"
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
    assert_match "remem 0.6.67", shell_output("#{bin}/remem --version")
  end
end
