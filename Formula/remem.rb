# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.17"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.17/remem-darwin-x64.tar.gz"
      sha256 "669282b09e009b2c9a7b0b1be5e9aa2ece2ca3f4c0e202e476f6dfc25f6cbd55"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.17/remem-darwin-arm64.tar.gz"
      sha256 "a24aa61434c7b87e080087bcf27e5865f716c8b759faa5520a7297d7e8747e57"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.17/remem-linux-x64.tar.gz"
      sha256 "e79b589bb1c75149fe972d95d17088cb2ea5e80119a7ec0c19b1d21fe4ed03b1"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.17/remem-linux-arm64.tar.gz"
      sha256 "1c62de9f1065086e17cc26aeebf385efd4993399f80ff351ee6d027031ab5e0f"
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
    assert_match "remem 0.6.17", shell_output("#{bin}/remem --version")
  end
end
