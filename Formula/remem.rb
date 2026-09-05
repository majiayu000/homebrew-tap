# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.90"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.90/remem-darwin-x64.tar.gz"
      sha256 "34c5146c92561eafcbadf1d1fc2f1a7ba3a6c60aa50f64b691280c7fa5d9a3a9"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.90/remem-darwin-arm64.tar.gz"
      sha256 "bd6a76c38f8d6812c9e750ae9bfeb5c7b31fc5f90e0444b1575c7c368490676c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.90/remem-linux-x64.tar.gz"
      sha256 "7e4b1cbc0ca0244b08f7b18672c1df36d81250f174119f73ebb89b8d475e4ba0"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.90/remem-linux-arm64.tar.gz"
      sha256 "e588f39550a40998dfca52ecb706038605d540c3ea2afebf12970c4acc3e40eb"
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
    assert_match "remem 0.6.90", shell_output("#{bin}/remem --version")
  end
end
