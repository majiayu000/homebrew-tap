# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.210"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.210/remem-darwin-x64.tar.gz"
      sha256 "1171d670a9154c61f4425bff6e699265dd35e6bf4aba90c3e44edac6ad1e09f7"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.210/remem-darwin-arm64.tar.gz"
      sha256 "8119a5efee93b12b6d025462260a14168e7b769349732ad688233b4b5190f7c0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.210/remem-linux-x64.tar.gz"
      sha256 "dd5b6186dfa106cfb8d4000bb79cf891b90d339d43db21aa544022cc7bccd951"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.210/remem-linux-arm64.tar.gz"
      sha256 "c8755517bea6840608bb0717985125776e3510ea56898ffcc718ba2a4adf0f24"
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
    assert_match "remem 0.5.210", shell_output("#{bin}/remem --version")
  end
end
