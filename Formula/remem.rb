# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.103"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.103/remem-darwin-x64.tar.gz"
      sha256 "1df9c78a69adab7895378b55574ee27d10ff5da3fd82801acaa5e1b04c8a01a1"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.103/remem-darwin-arm64.tar.gz"
      sha256 "74756e43bc9b9b0d7e09ed6479aa65f6ac03487ca72f0a872129b46ab2a91cce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.103/remem-linux-x64.tar.gz"
      sha256 "c6e706351090c0a2d064bec2b7014bb7e8efd4234e5546847dbec2ee8f0364bf"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.103/remem-linux-arm64.tar.gz"
      sha256 "a30f869270d9ae05beeb6ba73a2b3b74cfcd0f750d71fec700aba954e214d224"
    end
  end

  def install
    bin.install "remem" => "remem"
    if OS.mac? && Hardware::CPU.arm?
      unless quiet_system "codesign", "--verify", bin/"remem"
        system "codesign", "--force", "--sign", "-", bin/"remem"
      end
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
    assert_match "remem 0.6.103", shell_output("#{bin}/remem --version")
  end
end
