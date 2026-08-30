# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.83"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.83/remem-darwin-x64.tar.gz"
      sha256 "d3886201f2119d85f980ae788130be0c48199c91a83ce2ae0c88f6e9ad058d4d"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.83/remem-darwin-arm64.tar.gz"
      sha256 "a7a6257519246a47c9a1e7c3cea8e5c8e5364e2b1164442c673269202736d582"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.83/remem-linux-x64.tar.gz"
      sha256 "ca953461b62d11375ce727adf1d294d7b2c41e3ef512472f1efcc6524d27282b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.83/remem-linux-arm64.tar.gz"
      sha256 "401596c36e32448b339b0abd71a59be2f42f84bd7b8ea002c97ac2f243219af9"
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
    assert_match "remem 0.6.83", shell_output("#{bin}/remem --version")
  end
end
