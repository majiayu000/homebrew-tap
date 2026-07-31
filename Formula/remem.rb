# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.42"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.42/remem-darwin-x64.tar.gz"
      sha256 "fcdf5706e9d08b7055d2d67a0568ad3cc010d5883bc3da96f1b963f22fe25f21"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.42/remem-darwin-arm64.tar.gz"
      sha256 "c3296d1f689f3e9e29ea9166ca06f4266e7758b494194871d3e7cadd75109138"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.42/remem-linux-x64.tar.gz"
      sha256 "b3874922d20d1a7969fa61ed1e4a6152e7eb00c93179e48565ecfa54be184ce0"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.42/remem-linux-arm64.tar.gz"
      sha256 "440fab7115c16d317f91ac6e644387d49fd3f899e815822c9ee4523471678b74"
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
    assert_match "remem 0.6.42", shell_output("#{bin}/remem --version")
  end
end
