# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.68"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.68/remem-darwin-x64.tar.gz"
      sha256 "17b46860ca9d09c442d274eee8e6d54f64647cfdf174131461df34afdcdcc5fe"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.68/remem-darwin-arm64.tar.gz"
      sha256 "cf920276f6c3636b587148b15f61dea1ae011a7e1c98dcac96b952422286ad19"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.68/remem-linux-x64.tar.gz"
      sha256 "ff9288d60b13f249841ad1e75d7338478a5aa08d933b860ddd3906e4c9272b2b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.68/remem-linux-arm64.tar.gz"
      sha256 "0ec291c3e90565e126815ff95ae9f01e1d93a5b63486b128e0fb494e1853272a"
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
    assert_match "remem 0.6.68", shell_output("#{bin}/remem --version")
  end
end
