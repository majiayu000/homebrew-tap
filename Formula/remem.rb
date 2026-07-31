# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.38"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.38/remem-darwin-x64.tar.gz"
      sha256 "26c55d05e28be438813015370a824b3dfec747d7bcd02873dbc2d5700b4aa990"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.38/remem-darwin-arm64.tar.gz"
      sha256 "a0a8f4ed4c35ed45c84766ad15637f725d2f818af6ca47a0f160aa222bab2f0e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.38/remem-linux-x64.tar.gz"
      sha256 "f1ab5ed815f0c80af33160bec6812656b2c53e6019dbb1e33bc26e8a2dc86178"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.38/remem-linux-arm64.tar.gz"
      sha256 "8af2715d50884a398e07961f1ae43519a3093f9f891c807419604c09c81a17ba"
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
    assert_match "remem 0.6.38", shell_output("#{bin}/remem --version")
  end
end
