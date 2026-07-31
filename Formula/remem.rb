# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.37"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.37/remem-darwin-x64.tar.gz"
      sha256 "d0257b39a863a1b33952d282e0530ceade94fe8d490303895389367801fa953c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.37/remem-darwin-arm64.tar.gz"
      sha256 "d7ada300f8effdc47a11817a24fd9a5deefb09574147bd07e10a08cd3791650e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.37/remem-linux-x64.tar.gz"
      sha256 "068658d5ef194d242f83a64ee3c2354e78f86845d521263d1d79c38acc28eb96"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.37/remem-linux-arm64.tar.gz"
      sha256 "f59b33826bd4800cf8c2219288d43e538104cd2fed783732b48bb5ed536455a0"
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
    assert_match "remem 0.6.37", shell_output("#{bin}/remem --version")
  end
end
