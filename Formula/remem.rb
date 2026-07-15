# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.207"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.207/remem-darwin-x64.tar.gz"
      sha256 "5b3b4decc64aa0d6879ad6d8812efec6ec6ef498c56321888cdc8b63aa73e9a3"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.207/remem-darwin-arm64.tar.gz"
      sha256 "76206bf6a8f5ef1d742af2c8de9a1b79ca9a7fc4a487b6595b71d6da01e04cc8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.207/remem-linux-x64.tar.gz"
      sha256 "e8a999f89c2991c282de13f0aa2342b5691a39bebad9c77ee6528e6fe7148496"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.207/remem-linux-arm64.tar.gz"
      sha256 "3936bce6b6de8c2b25c69aa71d38efe470baba2b2a51d756aff89ca5d907481d"
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
    assert_match "remem 0.5.207", shell_output("#{bin}/remem --version")
  end
end
