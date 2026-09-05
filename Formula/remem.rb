# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.89"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.89/remem-darwin-x64.tar.gz"
      sha256 "125189b44e05b15370ca7e1dc6182c689d6b3563248a14b0c94682605f6f3a48"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.89/remem-darwin-arm64.tar.gz"
      sha256 "3ef389beb3672cea0a8440df16fff40837a108660ec5ab9b45710ab2e9e19546"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.89/remem-linux-x64.tar.gz"
      sha256 "fdaaf3b7f57c1ca07db1a8171d71683da38b21dae5507247c224bfb4943053fa"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.89/remem-linux-arm64.tar.gz"
      sha256 "392da86f0da4334df756f76a6de2a4f854bd36ef5cd108dc999fa3bac309ac90"
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
    assert_match "remem 0.6.89", shell_output("#{bin}/remem --version")
  end
end
