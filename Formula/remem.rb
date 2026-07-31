# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.36"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.36/remem-darwin-x64.tar.gz"
      sha256 "ca70b0ef79a2b865bfc3c82b761da595a9acd0bed4650827526ba9c041adb311"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.36/remem-darwin-arm64.tar.gz"
      sha256 "44200e800162cb4579be0ba8ee4406f02bf5d66f115f29b708c5352921cf71e2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.36/remem-linux-x64.tar.gz"
      sha256 "7efffa6134cda78107ecd1bc0dfc4f3b1d8df81b716e7f92fa7ec982c545d3c0"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.36/remem-linux-arm64.tar.gz"
      sha256 "145bfb7c92597b01bd2b6951f2b62de3f533bdb07a0e4b7f94c286c94ae1fc93"
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
    assert_match "remem 0.6.36", shell_output("#{bin}/remem --version")
  end
end
