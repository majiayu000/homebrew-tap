# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.6"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.6/remem-darwin-x64.tar.gz"
      sha256 "95ebeda8fdf817d4c36f93c0c612967d1159d4e03bd1e14ca9ab2dca8be13165"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.6/remem-darwin-arm64.tar.gz"
      sha256 "b7387da36f9aae9cea215dd082ed57d4fd8e6e580fb59df4dbccd4500799a9f9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.6/remem-linux-x64.tar.gz"
      sha256 "a65bfe107dc81e6376e214d96e27cbd0dd1c8b8da2fdfdc0569b5e724d6292ac"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.6/remem-linux-arm64.tar.gz"
      sha256 "f86ff03f74e290e4ea1fa9651f45059c54fabb0bd0c4707bbc69124115466b0c"
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
    assert_match "remem 0.6.6", shell_output("#{bin}/remem --version")
  end
end
