# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.205"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.205/remem-darwin-x64.tar.gz"
      sha256 "ff9c99cc652236b2aeafe19bfff40e12ab2e38f1719628a7800f07135912b41b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.205/remem-darwin-arm64.tar.gz"
      sha256 "bbd6876d24f20b28fff2430afa0a1cbd384101f64dc1e79453c88a2bd312789a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.205/remem-linux-x64.tar.gz"
      sha256 "d720c3114d1054ac18da4cfc0f4c7d37df6f5c35b819559494c93b6b5f34dd09"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.205/remem-linux-arm64.tar.gz"
      sha256 "62a8137e0b6e54f5b25349d2280ebebc7ab1843d13f3c57e82a7e3141abd4077"
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
    assert_match "remem 0.5.205", shell_output("#{bin}/remem --version")
  end
end
