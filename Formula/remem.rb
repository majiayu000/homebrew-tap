# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.80"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.80/remem-darwin-x64.tar.gz"
      sha256 "f40b60174bfc9cb0952b5d9ad030505ab39fd45adaa98cc84a8bc9dd2cb993ec"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.80/remem-darwin-arm64.tar.gz"
      sha256 "10b27448ed2cbcb487f9b47cf100bacf1b44fe9f6307f3ea8f0cbcab42cea215"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.80/remem-linux-x64.tar.gz"
      sha256 "81850d8f214b5de95e79a88fbdd7f7b935f24b90b475d63d23afd0b04ae1897e"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.80/remem-linux-arm64.tar.gz"
      sha256 "235690d9bae162867455f63a3fc33bcfde77a54977018a7d28d4e5609d6de7fe"
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
    assert_match "remem 0.6.80", shell_output("#{bin}/remem --version")
  end
end
