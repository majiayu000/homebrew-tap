# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.31"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.31/remem-darwin-x64.tar.gz"
      sha256 "af7f31531ea73a29771587fdfb6ad352f7cadbd31c6ef58f3671854cea976880"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.31/remem-darwin-arm64.tar.gz"
      sha256 "ca1eac85be7407d34442d1e4bd2a3be94f7a6ee97b16ecf830492d767d0290fc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.31/remem-linux-x64.tar.gz"
      sha256 "7d31de8004b0970fab91bfae415f9175f7ad0c84074af7b3a588ad403be5ad68"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.31/remem-linux-arm64.tar.gz"
      sha256 "490b1a708443bf5ff11016ae23b9eab783d7f523372c5e47f32d748101316493"
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
    assert_match "remem 0.6.31", shell_output("#{bin}/remem --version")
  end
end
