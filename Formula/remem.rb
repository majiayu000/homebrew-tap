# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.212"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.212/remem-darwin-x64.tar.gz"
      sha256 "6e81be06d563e54e01e72fd7946405f28de5b1e32169e202852f9981d7e741e0"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.212/remem-darwin-arm64.tar.gz"
      sha256 "11dcbddec9724905d2d88417658469af1a2e41bd638ed1f17c608b22249cbcbd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.212/remem-linux-x64.tar.gz"
      sha256 "f745bf2f5b56f79564af2281e3f91f9ab3e38019959a36e45b712a13a979bbb6"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.212/remem-linux-arm64.tar.gz"
      sha256 "7d21b93373606456fae9957fecbc7759756456c996ca7e07aacb6ea1342c12a1"
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
    assert_match "remem 0.5.212", shell_output("#{bin}/remem --version")
  end
end
