# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.197"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.197/remem-darwin-x64.tar.gz"
      sha256 "f6d736bb8f85b642d9a50e019a1b7303ab16ffc0fa3127431e9384d9977a5d0e"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.197/remem-darwin-arm64.tar.gz"
      sha256 "685b8038fa94a6783aaaa76e0e9d9fc1106bd0c0673952e33c71882d21bfb854"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.197/remem-linux-x64.tar.gz"
      sha256 "8ce842106405b8df7a714e9b1c53998a30cb2353b0544701c395cc6ebd07f579"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.197/remem-linux-arm64.tar.gz"
      sha256 "88b8d141c15ddb8f296e33cb2186ae27c87bebf286ed2418e7e3a06b8cbb4613"
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
    assert_match "remem 0.5.197", shell_output("#{bin}/remem --version")
  end
end
