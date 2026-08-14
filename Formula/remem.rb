# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.73"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.73/remem-darwin-x64.tar.gz"
      sha256 "ab08d090678b07b7cdb1ad78ff8dfdb879bcfb64e8cdcb6784fdbebc57d37059"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.73/remem-darwin-arm64.tar.gz"
      sha256 "f47bbe55f363ce17e60ceb2b02d9cafb968ad5679c15099e90f8fb34e169b57d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.73/remem-linux-x64.tar.gz"
      sha256 "fb30b80cfb5160ee550669912a4766bd57d67dc6bc7a636a119c602eee087b67"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.73/remem-linux-arm64.tar.gz"
      sha256 "270fd20eebe60939f82d5fd84a1b2c57e318a0a2bc5ef9081200403871b5ff10"
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
    assert_match "remem 0.6.73", shell_output("#{bin}/remem --version")
  end
end
