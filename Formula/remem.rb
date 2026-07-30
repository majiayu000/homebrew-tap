# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.35"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.35/remem-darwin-x64.tar.gz"
      sha256 "3bf3e32c5818fac00f0c9896b124d1c8da412037eb563922bd08af3526bcc1f2"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.35/remem-darwin-arm64.tar.gz"
      sha256 "4020e91cbc2c757e71ed86adf6db85531ea5bc2ea65b9a8db8535a7bae037c21"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.35/remem-linux-x64.tar.gz"
      sha256 "c349002023a82d7db6dfe49451c34bf7e779f00f1e714f679fadb1e7f77df2a0"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.35/remem-linux-arm64.tar.gz"
      sha256 "89c1fc1344ff90889ca6c0a921b25ee45304715ba55a9e21f689ec3e1acf15ba"
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
    assert_match "remem 0.6.35", shell_output("#{bin}/remem --version")
  end
end
