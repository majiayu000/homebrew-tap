# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.211"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.211/remem-darwin-x64.tar.gz"
      sha256 "8225e47fdb7ee7554762a62f8ddd0e2770f598c215f565b318327e37b430a853"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.211/remem-darwin-arm64.tar.gz"
      sha256 "258fc5951e683b7c74ad58c4fb861ee27a1463ce180f36e10d53f8aa1055ebac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.211/remem-linux-x64.tar.gz"
      sha256 "b8f15f17903d479a979167867ab2eea2cd624b06e389737dba407ff3b6e9c71e"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.211/remem-linux-arm64.tar.gz"
      sha256 "11672ea3fe02c2cbaf5f1f9e23a3d5e6df14a29829a4e82e540bd7d0b768f40d"
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
    assert_match "remem 0.5.211", shell_output("#{bin}/remem --version")
  end
end
