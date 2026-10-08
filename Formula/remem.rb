# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.104"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.104/remem-darwin-x64.tar.gz"
      sha256 "030fdc0d100ac93b6240085925765aa1dbe7e8666e08421d1aad5b40fde0509b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.104/remem-darwin-arm64.tar.gz"
      sha256 "499b5b14561c169270d23c2d8782a07669579f8bc6e46c59e9a03c1adc57b976"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.104/remem-linux-x64.tar.gz"
      sha256 "9637adf6900ce3179dceade662abd8db393d7e5a34bebf0931428e7af87fec37"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.104/remem-linux-arm64.tar.gz"
      sha256 "c73debc33331c1030e33acb29954438929ab6fbfbe97c12761be6a7bae35ec20"
    end
  end

  def install
    bin.install "remem" => "remem"
    if OS.mac? && Hardware::CPU.arm?
      unless quiet_system "codesign", "--verify", bin/"remem"
        system "codesign", "--force", "--sign", "-", bin/"remem"
      end
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
    assert_match "remem 0.6.104", shell_output("#{bin}/remem --version")
  end
end
