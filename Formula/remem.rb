# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.58"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.58/remem-darwin-x64.tar.gz"
      sha256 "926294523ceace11e4f35a868d78e1b2293102ea07e7628721d6a7aa28672e84"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.58/remem-darwin-arm64.tar.gz"
      sha256 "6eb85b12602678b622955af68a2a9f2c76a4d38209fbde0241c4c9abfc42f864"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.58/remem-linux-x64.tar.gz"
      sha256 "83babfcd5fed973902b7e4daf1ddf769db5c856ab1b580008069b29cb463e44f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.58/remem-linux-arm64.tar.gz"
      sha256 "0c02282b008170a37d32655a6902e243168d2545876b85bd28c2ddf15460efc7"
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
    assert_match "remem 0.6.58", shell_output("#{bin}/remem --version")
  end
end
