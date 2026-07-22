# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.15"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.15/remem-darwin-x64.tar.gz"
      sha256 "b3ebd6b3fbe0e93405e75504296278feb1f2caa8bc646d03b14a2285ee01079f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.15/remem-darwin-arm64.tar.gz"
      sha256 "5626bb06904242918c7cd0a1ce212249714b51b4078cc2ba3cf419ec4931e140"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.15/remem-linux-x64.tar.gz"
      sha256 "d298a4bd304c05c2ed85d49a165e8b03cd8be918a2fa7ba0c2b28a5120079442"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.15/remem-linux-arm64.tar.gz"
      sha256 "22d5bc3ca5296aa21eabf69c99f4fe108f42706fabb2b224fd2c8872d747e0c4"
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
    assert_match "remem 0.6.15", shell_output("#{bin}/remem --version")
  end
end
