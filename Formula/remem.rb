# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.5"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.5/remem-darwin-x64.tar.gz"
      sha256 "001713a727fdd6b6766b486f2c69d5490c06ae228071f0435d86b1d739ab618d"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.5/remem-darwin-arm64.tar.gz"
      sha256 "e4285f9c20d374124d0f36451a475dcbed4f1917f056cd4b5c5c3a30f6c50142"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.5/remem-linux-x64.tar.gz"
      sha256 "fc97080a25c5a980e301355818c37ba8ffb45fc3c25a47cff2726b333e571b67"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.5/remem-linux-arm64.tar.gz"
      sha256 "231ad208878c70cbb337633d29a78f057fc8c75dc637d540300c2cd85c524905"
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
    assert_match "remem 0.6.5", shell_output("#{bin}/remem --version")
  end
end
