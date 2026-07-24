# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.18"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.18/remem-darwin-x64.tar.gz"
      sha256 "c723775a0701dc33276565a7563b981fbdb5d6f1b5b4c4d94c32d70694b83560"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.18/remem-darwin-arm64.tar.gz"
      sha256 "d4823cf88932b925fcd0565fa1a206a0a2f4a58e8923256ba95cd21562a14116"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.18/remem-linux-x64.tar.gz"
      sha256 "84ed1549397685ae01005509ae97a2aa20f1e0d09ebe98dd2fc00d4424d6078c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.18/remem-linux-arm64.tar.gz"
      sha256 "3217fe85845f7cbdb01ea3e69e75caa150d377218a2c5e8b43fb3a3f7ecbded7"
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
    assert_match "remem 0.6.18", shell_output("#{bin}/remem --version")
  end
end
