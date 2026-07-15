# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.204"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.204/remem-darwin-x64.tar.gz"
      sha256 "fa1fee104fb058aa5118a6aebd304404bc9b6b39fcf82059f6c8be2722494dd4"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.204/remem-darwin-arm64.tar.gz"
      sha256 "fd83ba45937e50b87b96dcdb96dc2744fa6c14869fac29bdff2436d888a3308b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.204/remem-linux-x64.tar.gz"
      sha256 "0756ffae7aaaaefcf73bcc9f461a4a4a054526f0fec8948803473785d93464c4"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.204/remem-linux-arm64.tar.gz"
      sha256 "2b4f05ead2a36f5708d2e700195bcd5ccfc1156241ddbbe8d530e518e158e5fb"
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
    assert_match "remem 0.5.204", shell_output("#{bin}/remem --version")
  end
end
