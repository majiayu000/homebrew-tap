# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.8"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.8/remem-darwin-x64.tar.gz"
      sha256 "f28c8451f86712448fd549463916f94b0feeac9397d3112e3d5ac96e16ec520f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.8/remem-darwin-arm64.tar.gz"
      sha256 "11672b415334b3ed06ee2a81b7ef0337210de2ba8b4cce5c536377173cc11579"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.8/remem-linux-x64.tar.gz"
      sha256 "c3083e357045fb88421e3b5267787908b55f3a6fd4ac0a27dd7435c96a13ec1c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.8/remem-linux-arm64.tar.gz"
      sha256 "5ccd040097b0bc4ce04b12306b9e79800f8ae72b76a79891d131847524d97ace"
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
    assert_match "remem 0.6.8", shell_output("#{bin}/remem --version")
  end
end
