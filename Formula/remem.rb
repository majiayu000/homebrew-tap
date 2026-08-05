# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.48"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.48/remem-darwin-x64.tar.gz"
      sha256 "1bdf312a493717ac20597577a1d7c54363cf4310d5065d197be99df13f21e9e8"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.48/remem-darwin-arm64.tar.gz"
      sha256 "5b0f2e1f86d80290f69afce87fb61a9d29c6d64bf2bf48ab472910ced91bd254"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.48/remem-linux-x64.tar.gz"
      sha256 "cc19287d2b8bf5ad899f05aaeca36c6d6b0e272a0ef330a4001b928e78268c1f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.48/remem-linux-arm64.tar.gz"
      sha256 "707997ac00040ece74304520081e29e131a21052f7041790d96cb3604f5e8f0b"
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
    assert_match "remem 0.6.48", shell_output("#{bin}/remem --version")
  end
end
