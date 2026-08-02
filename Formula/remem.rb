# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.45"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.45/remem-darwin-x64.tar.gz"
      sha256 "85b2749e4452b49b617025825d79528a62d6013772fc66dd2e9cd6a59b4e3a2a"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.45/remem-darwin-arm64.tar.gz"
      sha256 "26eed0a2e475f328409a013da45ade36469e96dcdf02712c22fdaabbcd0bdfb7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.45/remem-linux-x64.tar.gz"
      sha256 "4929cba21da6b5292f08d0b9421c08c171b514d1efe5ae6668ce6b589df57874"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.45/remem-linux-arm64.tar.gz"
      sha256 "d1088c8dadb1c3d529d4bb608e568e914460c82af47c5776d6dbfcf2cda1144a"
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
    assert_match "remem 0.6.45", shell_output("#{bin}/remem --version")
  end
end
