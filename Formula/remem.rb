# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.33"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.33/remem-darwin-x64.tar.gz"
      sha256 "ff5ddf9afaf48eae137d7c4a85bcc7d4e063fbf99a6f9771693ccd7ee705c405"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.33/remem-darwin-arm64.tar.gz"
      sha256 "b0596e7c2f65f922123efffbcf73ae6c927e6f2ce9127a0e7261551a6a62df9c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.33/remem-linux-x64.tar.gz"
      sha256 "eed7755590ad1700e8dd46312ab50e48ac14ed85ec6420e105573870119ffa28"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.33/remem-linux-arm64.tar.gz"
      sha256 "0bbc9febb16404351bb0ae4f8b18321eba08690b497324efa44d815ef61cbf21"
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
    assert_match "remem 0.6.33", shell_output("#{bin}/remem --version")
  end
end
