# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.21"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.21/remem-darwin-x64.tar.gz"
      sha256 "0da321b8a9f36dbdafb00ccb466a40ea79ac66f922692bf30aa1d96b3a969435"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.21/remem-darwin-arm64.tar.gz"
      sha256 "0ee87d04cfbf5f3cc34d2ae369c96c9dcd2376b2946067b032c4041743c1b9f8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.21/remem-linux-x64.tar.gz"
      sha256 "c975282984967c86eb840df89fb728faf225f25dad58cd999abc25d3bfc55c21"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.21/remem-linux-arm64.tar.gz"
      sha256 "87a2ce6d61c2e92b22d165eb1c484974763562bafc2fe39fbc93019eaf3c69d5"
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
    assert_match "remem 0.6.21", shell_output("#{bin}/remem --version")
  end
end
