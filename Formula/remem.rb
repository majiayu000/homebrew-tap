# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.93"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.93/remem-darwin-x64.tar.gz"
      sha256 "db95474708bffe0c2b79051d07a0582f5cb7970cb3a66e8dc7de02fd7a43d896"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.93/remem-darwin-arm64.tar.gz"
      sha256 "246b5429fa2b141424ba95186b2f2317f796c0f4b27b1c14ee5d8b9a10167d81"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.93/remem-linux-x64.tar.gz"
      sha256 "72fe4b6b06ad540a6ec84a063c793012bc858289524bcf8c5b9e335dcc5fedbc"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.93/remem-linux-arm64.tar.gz"
      sha256 "5531695e878a5992f0eef7c3914d66e1510d314aff4909f16cf1c19930b75b1d"
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
    assert_match "remem 0.6.93", shell_output("#{bin}/remem --version")
  end
end
