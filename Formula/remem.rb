# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.7.11"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.11/remem-darwin-x64.tar.gz"
      sha256 "26bfd2886fafbf0ef7e395a2435c1b2ad7ca2394f9abc9e3d6efbc5804f90197"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.11/remem-darwin-arm64.tar.gz"
      sha256 "e28b14a7368bf15cc55ae9ae9bd04da1d66cdd32a50c1b5356c08c3072359564"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.11/remem-linux-x64.tar.gz"
      sha256 "d0046d5ddd1df07e6f90952fa4118a9fe990439f847b014d8a2e4278cada6182"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.11/remem-linux-arm64.tar.gz"
      sha256 "daebf76a21d32f406e3240f72688802fc8dfd4eaa11fdba79d43f26012f6ecb4"
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
    assert_match "remem 0.7.11", shell_output("#{bin}/remem --version")
  end
end
