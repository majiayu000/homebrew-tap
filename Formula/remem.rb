# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.4"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.4/remem-darwin-x64.tar.gz"
      sha256 "8de9c7ff1454382ca3643b4ba7d340685b33db1f4c19a5fd1e1a01e3c3172165"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.4/remem-darwin-arm64.tar.gz"
      sha256 "6dffb8dc3cd03fffdef3622f78f812700cb98de262e34375903e200a050a7942"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.4/remem-linux-x64.tar.gz"
      sha256 "64482084fce13ace6ecb375eb3a038697668298050bd3f2f84b277cdef1a7a83"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.4/remem-linux-arm64.tar.gz"
      sha256 "fc0e324b0870ffa23de0a03b540520497822cbd2484225fc68ded1cb83e960ce"
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
    assert_match "remem 0.6.4", shell_output("#{bin}/remem --version")
  end
end
