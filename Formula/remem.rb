# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.44"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.44/remem-darwin-x64.tar.gz"
      sha256 "29ebb47860414a48cca97c4e1af805010a10dede039ebd5e4eb06bab01e5e787"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.44/remem-darwin-arm64.tar.gz"
      sha256 "1245e59019797469616339cf598cb4abd5bebbd731ac91ebf32259c23f07b0c2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.44/remem-linux-x64.tar.gz"
      sha256 "30d2b23816f36485c49346e3aed3975d02f192a80df590d654e8061e2e9aa203"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.44/remem-linux-arm64.tar.gz"
      sha256 "4f06d9469021eb4e228ad420980f184378eac01899d5db5889643db6b71f1e2a"
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
    assert_match "remem 0.6.44", shell_output("#{bin}/remem --version")
  end
end
