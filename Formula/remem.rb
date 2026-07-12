# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.200"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.200/remem-darwin-x64.tar.gz"
      sha256 "f6e689da76ed3e7c22f3d20140cd5d6e1e9f709f83ed72481c23d8f5aa61719f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.200/remem-darwin-arm64.tar.gz"
      sha256 "381269004222e22178a8e9b1c4c915ba1d04728e8d6b329807ddae902812978d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.200/remem-linux-x64.tar.gz"
      sha256 "832bafd11e3eff7696a5fd0b720fa68db49ca8048b6a5cc1a03a6461e9f0d980"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.200/remem-linux-arm64.tar.gz"
      sha256 "cd5c3d08676641f95ef8beff62a9b5cc8f330624bb5ef9d194bfb7fb1fcb5498"
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
    assert_match "remem 0.5.200", shell_output("#{bin}/remem --version")
  end
end
