# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.199"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.199/remem-darwin-x64.tar.gz"
      sha256 "3cc28b471b731da48937be35ca8698319230e20796a2802a4c77cb71f437767b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.199/remem-darwin-arm64.tar.gz"
      sha256 "4e9bd045641d44040b7aa53e4db371f81578e9364c2e8981efe2c6b779820363"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.199/remem-linux-x64.tar.gz"
      sha256 "3b8ff7a68e3d344a260e039d11bf1d0d8c0fb4be590c35fa6aae170e1af7ce4e"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.199/remem-linux-arm64.tar.gz"
      sha256 "69a6e52a09148f7825d5b999004634ea7bc6c89a2fed3ab2523d2849c13fc6d2"
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
    assert_match "remem 0.5.199", shell_output("#{bin}/remem --version")
  end
end
