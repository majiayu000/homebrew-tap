# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.34"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.34/remem-darwin-x64.tar.gz"
      sha256 "79b84b69b28da3246cbd758a35926971ef6d0aff1db0be7bfb30bc674ac503a4"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.34/remem-darwin-arm64.tar.gz"
      sha256 "9c680ca116792b60ee3dff732f51d14bf4765aa32901377427dddb1a25e804e2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.34/remem-linux-x64.tar.gz"
      sha256 "0db114911467d5e7d249c8a69eca57aeb8eebbaf226e3b04a0d63bc0ec474e46"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.34/remem-linux-arm64.tar.gz"
      sha256 "bbd51d23d504aa5135a4ffc5cf686d4f480956e97f4f42f6b48b4e59883c2ea4"
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
    assert_match "remem 0.6.34", shell_output("#{bin}/remem --version")
  end
end
