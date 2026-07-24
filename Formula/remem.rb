# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.22"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.22/remem-darwin-x64.tar.gz"
      sha256 "456411e16b29a1cfe364b56d2b41f6b9f8be905e6b2521591f8ed417680ab973"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.22/remem-darwin-arm64.tar.gz"
      sha256 "13834f0df6cc359c682e77858e30db72e9f616eb17f6d0059e3fe7af579112ef"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.22/remem-linux-x64.tar.gz"
      sha256 "6e278f19c17cd07b82d7abd28b465a2515a3782e89613aa7d0ec5968573c6bf3"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.22/remem-linux-arm64.tar.gz"
      sha256 "0cf19b51241b9976d1ea6644239f941b590e8ea6169548ec93a007519b6fa87a"
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
    assert_match "remem 0.6.22", shell_output("#{bin}/remem --version")
  end
end
