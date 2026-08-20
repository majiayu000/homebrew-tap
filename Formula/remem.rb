# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.79"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.79/remem-darwin-x64.tar.gz"
      sha256 "f5c2ca798f351130ffe846ea2fcf48d6bfe8d42cdd880083f9ba15e71b08e2ce"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.79/remem-darwin-arm64.tar.gz"
      sha256 "45b75a0fdb237daf86fbb0d402711d8fda5170cc84e5b24bac2d694362e9eb1d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.79/remem-linux-x64.tar.gz"
      sha256 "25de3c9f63e98206fc54fe7b5bb6d0630cd16b0af37f8d3132eb85bbe1e3a7df"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.79/remem-linux-arm64.tar.gz"
      sha256 "f1a7dfca8040a5d2580e770cf0cce57610fb15326cc9f9a9960664531d7f5be5"
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
    assert_match "remem 0.6.79", shell_output("#{bin}/remem --version")
  end
end
