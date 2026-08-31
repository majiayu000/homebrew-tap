# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.84"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.84/remem-darwin-x64.tar.gz"
      sha256 "1d7bbae85dc566413803f59bb17535c3bfe7da10f30e30a10ffdff95f9897da2"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.84/remem-darwin-arm64.tar.gz"
      sha256 "989ad4f4b75b18ff177a5c53075f23b16c8b2c4948aabc631bc9236585c3384d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.84/remem-linux-x64.tar.gz"
      sha256 "bea4207fca81cae329096aa409125a21b1102e7ca8df4d63b01cc38d1caa84f4"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.84/remem-linux-arm64.tar.gz"
      sha256 "00f95e4607c15c1d908cdb4782c2a91cbea1181a32cc4f4498ec77d573169e91"
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
    assert_match "remem 0.6.84", shell_output("#{bin}/remem --version")
  end
end
