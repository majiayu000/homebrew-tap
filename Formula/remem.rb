# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.40"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.40/remem-darwin-x64.tar.gz"
      sha256 "bb0b111d5b08bda88385226ae97202a392c37091e824fa5325c8d3756a58609b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.40/remem-darwin-arm64.tar.gz"
      sha256 "6684d96dc73c3dd01ab1bb2cdb6ec75bb2ce76a4f417b375eef40d9b244e5bbc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.40/remem-linux-x64.tar.gz"
      sha256 "2d4649adc9eb816495f42d271784cb7094fb8a3433aa6e1d1cd6fad67dd49fd3"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.40/remem-linux-arm64.tar.gz"
      sha256 "b02595bf6fdab49a33429348425745511855d625aa7a790d77432bf8ebc6c9f4"
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
    assert_match "remem 0.6.40", shell_output("#{bin}/remem --version")
  end
end
