# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.13"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.13/remem-darwin-x64.tar.gz"
      sha256 "a3da0c02c6b8de97991ffb5947f18d17f38b57f9f8b7e1487a49965b40e2841f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.13/remem-darwin-arm64.tar.gz"
      sha256 "abcd07e07be082e84de48b049ec20a59e489dc35e9a1b3ecc260f518a840cefc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.13/remem-linux-x64.tar.gz"
      sha256 "cffa4d7c63d4f5c7a7a2a21592fc17b3dab6333120a9b8cfe2164975999c71fa"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.13/remem-linux-arm64.tar.gz"
      sha256 "9b9cd0ed160a07c5add7843941f141291c2278fe147ff70d138b98e4cd80cb4e"
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
    assert_match "remem 0.6.13", shell_output("#{bin}/remem --version")
  end
end
