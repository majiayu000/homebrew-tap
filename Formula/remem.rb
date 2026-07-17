# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.3/remem-darwin-x64.tar.gz"
      sha256 "671c013eeb631e696825eb15ddab6ccf68523479bc4e0e2be24a389659892400"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.3/remem-darwin-arm64.tar.gz"
      sha256 "cc952e048b2432afa10ffb632577bdbea9aa1917c8ee29d44a8c4919f4f2c9e4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.3/remem-linux-x64.tar.gz"
      sha256 "863ea14d801fa6f7ee0f23295419ddc3fca46e9f375669c18d4c8ae56125e7cc"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.3/remem-linux-arm64.tar.gz"
      sha256 "d91b1f053a50d346e56ab98b65331a9ed7af7b537d6413c506bc3b11459344f4"
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
    assert_match "remem 0.6.3", shell_output("#{bin}/remem --version")
  end
end
