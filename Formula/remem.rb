# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.27"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.27/remem-darwin-x64.tar.gz"
      sha256 "d4dcc622dec6e18d79c13ebc100a2b5eb6a51ce6b145416e2137679851e70960"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.27/remem-darwin-arm64.tar.gz"
      sha256 "f84bd2387cce628dc0a43ffaa1134fc958f6caf5b7792715ffef2f8ddaa24a68"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.27/remem-linux-x64.tar.gz"
      sha256 "84315c82ce54124bf505145c25833124c339fa8e83aba0a06142f953181c0d3b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.27/remem-linux-arm64.tar.gz"
      sha256 "98b8aceab37d3898f2a0dc88855a7c53447c5f313c9f729913a7947f40b981d3"
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
    assert_match "remem 0.6.27", shell_output("#{bin}/remem --version")
  end
end
