# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.214"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.214/remem-darwin-x64.tar.gz"
      sha256 "c8afbab12e475d93079c12e906a6e5b4d90e25c65050cd8331218d3f689731ef"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.214/remem-darwin-arm64.tar.gz"
      sha256 "925f94085fa6fb4bc27cf8bae50b88d40d2845a0149da425a6a31033ab63d13e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.214/remem-linux-x64.tar.gz"
      sha256 "0ab376fd8fe0b5947f5db645946f6b35866b8ddca017cbb6f58b11cf3f797b45"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.214/remem-linux-arm64.tar.gz"
      sha256 "1ff412a673725d4c09b2fb84a9cbf8d77f91557135854568c50c1f8a95386191"
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
    assert_match "remem 0.5.214", shell_output("#{bin}/remem --version")
  end
end
