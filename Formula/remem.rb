# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.19"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.19/remem-darwin-x64.tar.gz"
      sha256 "0675605f44baae0d550f6b8b60531efa98f98cbde8f8ea692bf3169f611c6973"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.19/remem-darwin-arm64.tar.gz"
      sha256 "22492ebb6df3a5f3532ee949c25ca7bdf562fd2576436029ef93dda0b4f0819e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.19/remem-linux-x64.tar.gz"
      sha256 "44223d30559a7cd19d216ddd79bda8c91b88ffe5320a590740cc01c8495dc824"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.19/remem-linux-arm64.tar.gz"
      sha256 "d0f70b42b9317ffe54cd1bf7560f7f4f8dda333239a5c10a69a176be6eec3deb"
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
    assert_match "remem 0.6.19", shell_output("#{bin}/remem --version")
  end
end
