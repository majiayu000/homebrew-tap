# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.26"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.26/remem-darwin-x64.tar.gz"
      sha256 "b2ebba33b41559b004dc3df0389636803a696d02274686ac3e23f78759247aa7"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.26/remem-darwin-arm64.tar.gz"
      sha256 "b17ea20986f9dc6b7e4da5db85b73ca457200637ec799edd7b985842897b27f8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.26/remem-linux-x64.tar.gz"
      sha256 "c62e1c84afa1226ec0a7d3df3cc8b5acc4ad69269d2aa24a9cd52792b8aff1c8"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.26/remem-linux-arm64.tar.gz"
      sha256 "23ffbf7b092f115236185d8b31ddcd9941ca609ced79da7e2050d46740c3968c"
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
    assert_match "remem 0.6.26", shell_output("#{bin}/remem --version")
  end
end
