# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.66"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.66/remem-darwin-x64.tar.gz"
      sha256 "aaf84bc5382abcf555a5c499b1154f20c936be63551ecb0ff00ef115b6490311"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.66/remem-darwin-arm64.tar.gz"
      sha256 "7a213dc0ce8b36e9ef7a6c269afa999410a1ed78c79557e10378b19a3bed5649"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.66/remem-linux-x64.tar.gz"
      sha256 "f4ad9b81ba472acbead9d619672a4daa9ea0540b255637c345fc337036bc4cab"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.66/remem-linux-arm64.tar.gz"
      sha256 "2ec2ba4a8f2f112dfb4ee17e63b958b7c6d7324573ec0ee159ab4da10167ab60"
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
    assert_match "remem 0.6.66", shell_output("#{bin}/remem --version")
  end
end
