# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.96"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.96/remem-darwin-x64.tar.gz"
      sha256 "415bc5df25b4a603189ce2ea67ae5830f5d85e611558bb3efeaa5e11f6587f46"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.96/remem-darwin-arm64.tar.gz"
      sha256 "37495ecfd7b4b1bb298743f95fc353973761d9f058bfea54378d3ad829209e1c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.96/remem-linux-x64.tar.gz"
      sha256 "5315590a59a53226a7284da378a5f54dbd1b279cd87e52bf16f13c6508f5d66b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.96/remem-linux-arm64.tar.gz"
      sha256 "595c909e1646a6f026ada5ef35f401d40759168e14ee85a85cfb13f87936e400"
    end
  end

  def install
    bin.install "remem" => "remem"
    if OS.mac? && Hardware::CPU.arm?
      unless quiet_system "codesign", "--verify", bin/"remem"
        system "codesign", "--force", "--sign", "-", bin/"remem"
      end
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
    assert_match "remem 0.6.96", shell_output("#{bin}/remem --version")
  end
end
