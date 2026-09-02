# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.85"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.85/remem-darwin-x64.tar.gz"
      sha256 "3e92f21f05c0063dfe0a31f04fef7c9613aa0b2a379c117e46ed31e75e283dc1"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.85/remem-darwin-arm64.tar.gz"
      sha256 "e36caf84945b462f620c75e832682e7f01efeb1cc95a8e836b06d1d76bd36fa5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.85/remem-linux-x64.tar.gz"
      sha256 "639ca1816b56376b25ed4071feb7cf081c2ebf5c599b1f3f609c4957c1f0f756"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.85/remem-linux-arm64.tar.gz"
      sha256 "88415c0ec6ffd367d53355a88cb3acc19119b1777a066a3e6ace80d6cf259b9c"
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
    assert_match "remem 0.6.85", shell_output("#{bin}/remem --version")
  end
end
