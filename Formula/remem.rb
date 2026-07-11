# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.198"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.198/remem-darwin-x64.tar.gz"
      sha256 "266d633e79aa3fd201c5a66ef1ea14a593870347e12cd175e32e9e0b422005cc"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.198/remem-darwin-arm64.tar.gz"
      sha256 "bf85f2e46b8e01e19582f95314dc189019cbd46eb602301eb160f4b420f7ec65"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.198/remem-linux-x64.tar.gz"
      sha256 "d20f85ccb0ccebc621bd11a71375675a22944353c410fef0bdb5c69f84bf597f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.198/remem-linux-arm64.tar.gz"
      sha256 "f88d5e037d38799d8f2ec7df387b6dbe5ab6820c515040e6be11dc54ec5422fd"
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
    assert_match "remem 0.5.198", shell_output("#{bin}/remem --version")
  end
end
