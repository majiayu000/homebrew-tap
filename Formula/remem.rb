# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.82"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.82/remem-darwin-x64.tar.gz"
      sha256 "09ec9729f8c7401a65b5200b57e036d2b39a53b6c4b627a32374aedd2ac024a0"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.82/remem-darwin-arm64.tar.gz"
      sha256 "19baa1ce89abb54bfb445f7b7bb0fac4993c6612e8dee8ea57355dc19a0c977c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.82/remem-linux-x64.tar.gz"
      sha256 "e30e4eaeb1aadb7fe458187467626081ee75b0e256de91749348db9b18f3f00a"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.82/remem-linux-arm64.tar.gz"
      sha256 "0c743d14f18f407cc33de969145b53be15ce1b485fb65c3a7247efecc8e3bc83"
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
    assert_match "remem 0.6.82", shell_output("#{bin}/remem --version")
  end
end
