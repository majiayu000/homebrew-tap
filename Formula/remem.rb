# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.202"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.202/remem-darwin-x64.tar.gz"
      sha256 "aca7765e3e01b33c5d4a037c62b4274a45d1b8914f0a3da9ef0e4ddd4a65fd00"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.202/remem-darwin-arm64.tar.gz"
      sha256 "caae53110bf2aaf7183c07cc839a92d13f8906aff8bf43d1c8fc3bf89d4755d2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.202/remem-linux-x64.tar.gz"
      sha256 "9d4a0977025c95f5be538ee39d17a5bcd131024c6d9b97687f1042dc13e9207c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.202/remem-linux-arm64.tar.gz"
      sha256 "ab9f0913eb5f0bf183f145558fbcd8117a2f22bd9c634ec79be470973fd2ffcc"
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
    assert_match "remem 0.5.202", shell_output("#{bin}/remem --version")
  end
end
