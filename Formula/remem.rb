# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.63"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.63/remem-darwin-x64.tar.gz"
      sha256 "34d1882b44d0182a9906952ee290f0cffadf17224117e266717e0f39fcf7ffc1"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.63/remem-darwin-arm64.tar.gz"
      sha256 "478f9c27962dd667ee2f7dd4d4b4081c39d7aee6be0c8998617b7f188b0c052e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.63/remem-linux-x64.tar.gz"
      sha256 "25be5751cd3e52fadb6829e8298c8e3c8f6fabaa96e4381b552b85b950ecdc46"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.63/remem-linux-arm64.tar.gz"
      sha256 "63164c93d08a3f71fdbed8943ae950235db5b3ac8694e4e3f645a4bfa36fca50"
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
    assert_match "remem 0.6.63", shell_output("#{bin}/remem --version")
  end
end
