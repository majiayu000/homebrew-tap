# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.97"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.97/remem-darwin-x64.tar.gz"
      sha256 "894ee7f263fa4f3be8715e08a615bbc62698ec33bf45b126e2bc683b6ccbb1dd"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.97/remem-darwin-arm64.tar.gz"
      sha256 "120e190b8a46b4b0e6c76f8600c0e6292200c08db13ba340648ec1bbc3596c31"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.97/remem-linux-x64.tar.gz"
      sha256 "9a54d11e1b6e334cec462741d57245c71d280adc829b83e81d3588d8304d383a"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.97/remem-linux-arm64.tar.gz"
      sha256 "2e1e6033242254d72a6d0af0cbe9b0449765be8422049340bab7d9ad19586817"
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
    assert_match "remem 0.6.97", shell_output("#{bin}/remem --version")
  end
end
