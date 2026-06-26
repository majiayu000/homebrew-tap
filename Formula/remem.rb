# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.141"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.141/remem-darwin-x64.tar.gz"
      sha256 "8ff46fdb77226f8d0cba15a401efc9c7e1ff89af3a80133897639251d73c8c80"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.141/remem-darwin-arm64.tar.gz"
      sha256 "cd5da453a8c852b937914b8f5bea149be50b40cb488dc5326529292c1a1be82a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.141/remem-linux-x64.tar.gz"
      sha256 "9667bd7da85d58ed9b91b368df43095e6c1bf6ecd5e6f27a3a965569ea8e9ae4"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.141/remem-linux-arm64.tar.gz"
      sha256 "4ff23b84ca9f7da99206952328c7f88ce3180026769afd2d86a9b1c2d9c3c55d"
    end
  end

  def install
    bin.install "remem"
  end

  def caveats
    <<~EOS
      Finish agent integration after installing the binary:

        remem install

      That auto-detects Claude Code and Codex CLI config directories.
      To force a host:

        remem install --target codex
        remem install --target claude
        remem install --target all

      Run remem doctor to verify or troubleshoot the integration.
    EOS
  end

  test do
    assert_match "remem 0.5.141", shell_output("#{bin}/remem --version")
  end
end
