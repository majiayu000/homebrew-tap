# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.47"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.47/remem-darwin-x64.tar.gz"
      sha256 "ccf5d754ff06bee82199a311130a658a2c4b50a8973d9b26f0f8609567e763a7"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.47/remem-darwin-arm64.tar.gz"
      sha256 "237bbdb5ad790acbca9aa5dda52109bfdfdf2c256f7e0130eda1bf9930e1d6ad"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.47/remem-linux-x64.tar.gz"
      sha256 "66e0bee65476834ae6b0a0ecf1ceb6c63392728560b67c2ecaf0358875630d6e"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.47/remem-linux-arm64.tar.gz"
      sha256 "4d1b82277091dfe0682b7e6e48c9e062718f37c89c5925de2092ecf94d4f2bf1"
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
    assert_match "remem 0.6.47", shell_output("#{bin}/remem --version")
  end
end
