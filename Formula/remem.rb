# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.57"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.57/remem-darwin-x64.tar.gz"
      sha256 "0358131659b4a6699b7446fef9b7d1962cc817fdf5df8342f4080c5fc677b719"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.57/remem-darwin-arm64.tar.gz"
      sha256 "d7b156bf9e20e57e959c2d6a67b185d853e652166e7aa2f28e56849510f9c2f5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.57/remem-linux-x64.tar.gz"
      sha256 "7c6dc787e9fc4b1fe44892310879ed128f0009f90f87918c18d7fbcfba00aee5"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.57/remem-linux-arm64.tar.gz"
      sha256 "3f971cd00ae8b6f0889011653a857969844146fe70e0968d0af566924e2a670c"
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
    assert_match "remem 0.6.57", shell_output("#{bin}/remem --version")
  end
end
