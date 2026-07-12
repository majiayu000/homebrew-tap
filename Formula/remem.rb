# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.201"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.201/remem-darwin-x64.tar.gz"
      sha256 "8c0f5aef5af265fd464ae7adef24df2699fd4f46e4b59260b637a14851484073"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.201/remem-darwin-arm64.tar.gz"
      sha256 "6a76c7968f9aa9fe16574f253c36a12fea92ee6b26769b973a67fb1abdb420bf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.201/remem-linux-x64.tar.gz"
      sha256 "be8175bab5159e2e37cf5c24c06bce4e9c26df445ae5f177d7b640f89f687ef8"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.201/remem-linux-arm64.tar.gz"
      sha256 "1b3bc2cd16b1652acb8615a618029683ff287d2a31c54466396dd0f97828ed93"
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
    assert_match "remem 0.5.201", shell_output("#{bin}/remem --version")
  end
end
