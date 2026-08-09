# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.64"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.64/remem-darwin-x64.tar.gz"
      sha256 "c634dd5308b185010180389185404481550dc108b1ea25dfbb7d4820f3d3cddd"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.64/remem-darwin-arm64.tar.gz"
      sha256 "b694dc5a0438aeb90e91b7f459951fe0b999da24f8195c53903ff60ab15762ae"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.64/remem-linux-x64.tar.gz"
      sha256 "d40b6faef8ebbf529e5945f8739b3fb47e5cb28d48f99fa1f2f45466a15d93d1"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.64/remem-linux-arm64.tar.gz"
      sha256 "2ec2fd492cde80d16e8d289769d2b69ee0648349e0c36e3ea4583c8fa38759b9"
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
    assert_match "remem 0.6.64", shell_output("#{bin}/remem --version")
  end
end
