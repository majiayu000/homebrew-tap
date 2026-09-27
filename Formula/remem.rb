# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.98"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.98/remem-darwin-x64.tar.gz"
      sha256 "05c135565863e246cec5e95c4b8c87b79450aed7f57c5067d1f878335e4af7ea"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.98/remem-darwin-arm64.tar.gz"
      sha256 "38da93f290cd6fef71c7ece2d05e3e36dc2527ee06e5032eafd811f0816f4dda"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.98/remem-linux-x64.tar.gz"
      sha256 "ed2c72bd2d3d0aba01998d31e9cdedf9817b117a31862e7a37c118181d676f83"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.98/remem-linux-arm64.tar.gz"
      sha256 "d6fe975debf850d40eee20a02453af4502c9b999beb406909d1b8573f5caa6d9"
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
    assert_match "remem 0.6.98", shell_output("#{bin}/remem --version")
  end
end
