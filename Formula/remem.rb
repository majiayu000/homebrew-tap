# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.209"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.209/remem-darwin-x64.tar.gz"
      sha256 "bbdedead5bc7c6f071cba5d4c2212415954d42643ffea8859d7e7c3eeea14ff8"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.209/remem-darwin-arm64.tar.gz"
      sha256 "27d5a1dc65033c64e43190e33390e954878a872bf915217043248a304231c1e0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.209/remem-linux-x64.tar.gz"
      sha256 "91cae0a5197b034fb386d9f02ac9680bbe4cc9d6f4f2d1635458e52ad64f41d5"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.209/remem-linux-arm64.tar.gz"
      sha256 "1a55a03ec488572c057c6246da5ca0cd7da4c7a309b00e4f7c561060f94436f0"
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
    assert_match "remem 0.5.209", shell_output("#{bin}/remem --version")
  end
end
