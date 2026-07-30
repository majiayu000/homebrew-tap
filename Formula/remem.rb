# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.32"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.32/remem-darwin-x64.tar.gz"
      sha256 "9202195e24d847aa0239361a9ca129bfa3e9836bc2f845ff0b0ce04cad3f8348"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.32/remem-darwin-arm64.tar.gz"
      sha256 "c0890363550a1439add0c262ba326ed52943d2e904e3ee5ef39031fec66d442f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.32/remem-linux-x64.tar.gz"
      sha256 "8464212c726f263056405400938e6b5f53c0f0fbce4f2bd4a63607664d580cae"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.32/remem-linux-arm64.tar.gz"
      sha256 "1512f811d4825af3e83d116e45de1ad7e15da4d03969c62e6c82c0029713c5ef"
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
    assert_match "remem 0.6.32", shell_output("#{bin}/remem --version")
  end
end
