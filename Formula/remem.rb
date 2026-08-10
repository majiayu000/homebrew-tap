# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.65"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.65/remem-darwin-x64.tar.gz"
      sha256 "43b234334f4b9856d6c7ecc16530020e65692acc7f398109900d9876c6d1de59"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.65/remem-darwin-arm64.tar.gz"
      sha256 "edea0db3cb3701d5db08a93907b8819b8e13f84cae2c2b037373e661670c79fe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.65/remem-linux-x64.tar.gz"
      sha256 "de3b535f854df1aeb085abcf07eb09199c6035ff36c5614c2ccdddbe2285fee5"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.65/remem-linux-arm64.tar.gz"
      sha256 "4216597b5799d4c0b8f1c54f99894ad442764f35ee83b132efcf9d96aa4c6151"
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
    assert_match "remem 0.6.65", shell_output("#{bin}/remem --version")
  end
end
