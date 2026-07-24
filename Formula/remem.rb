# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.20"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.20/remem-darwin-x64.tar.gz"
      sha256 "e4efb2377d9ffb66992bd7f57fa826e87196d08191ee4f0a021144a0ef470c25"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.20/remem-darwin-arm64.tar.gz"
      sha256 "6b077180485d46347fbb8879125ccc8264733f4b88675bc2fb7cd0c90144d7fb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.20/remem-linux-x64.tar.gz"
      sha256 "46b8442d0a5c7409c387b32ad84d908d1233ff126931628696ad92d39d6206fe"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.20/remem-linux-arm64.tar.gz"
      sha256 "ac6c70a42529d74f0e2077127e40649fdd0c36a692c8718f4fcc3ad9b36b5461"
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
    assert_match "remem 0.6.20", shell_output("#{bin}/remem --version")
  end
end
