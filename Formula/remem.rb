# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.203"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.203/remem-darwin-x64.tar.gz"
      sha256 "251f6b508be6547a60433986bda259ad256c93cb8782b6b939f387d72962b6bd"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.203/remem-darwin-arm64.tar.gz"
      sha256 "f45964ea0b2c7f9043645b2acc9c75466722db954af932e664e5b96aa20c4580"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.203/remem-linux-x64.tar.gz"
      sha256 "47169d38806c2a5b425a13fb0249881f02b4d2f0b65776168dc73f685cb1cfbb"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.203/remem-linux-arm64.tar.gz"
      sha256 "20a5e9af3a4120b5094a5edb75941dab933fe932264513f2b57ef60d4d0c86d0"
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
    assert_match "remem 0.5.203", shell_output("#{bin}/remem --version")
  end
end
