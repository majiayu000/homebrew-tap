# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.14"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.14/remem-darwin-x64.tar.gz"
      sha256 "63d0a9af63eb490243e0626f8e0e6b169b038f7aa201813fcf2a03ff538c1044"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.14/remem-darwin-arm64.tar.gz"
      sha256 "826d52607e9af0c71ced9d14c89c075311fa12a210e4a7adb87c49a25cbe0f0a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.14/remem-linux-x64.tar.gz"
      sha256 "9237c40f204538a6324940707906c7b828c3dd2f43836aaef1fe60afa8e8ac64"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.14/remem-linux-arm64.tar.gz"
      sha256 "ba32bfe2917528acfd6c1fc1fa9f88fe205174af6f4fe06b06e1cde860d29f19"
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
    assert_match "remem 0.6.14", shell_output("#{bin}/remem --version")
  end
end
