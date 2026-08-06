# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.51"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.51/remem-darwin-x64.tar.gz"
      sha256 "2e36e15c4935e6c6bbca4fd58c9c508b64e3aab8b4e054135552fdf4f74e128e"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.51/remem-darwin-arm64.tar.gz"
      sha256 "d3ddf6e6f221af1fb8430f87517e2072c8419d14e66b4b5013b57297e5cae8fa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.51/remem-linux-x64.tar.gz"
      sha256 "f71bfe9f4d2b44142ff115cd4d586cfb09d6b1a70ae90bdbab4cadffb3e9dc21"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.51/remem-linux-arm64.tar.gz"
      sha256 "a980727aacc0f2e5d121958b47cb6e6d42bdafa6647c7d961627204d02159e62"
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
    assert_match "remem 0.6.51", shell_output("#{bin}/remem --version")
  end
end
