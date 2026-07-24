# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.23"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.23/remem-darwin-x64.tar.gz"
      sha256 "48333c7076c46f7eb48560df754ee9e3f23b63d374fe5fecaaa6eda45c0b1a84"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.23/remem-darwin-arm64.tar.gz"
      sha256 "376f65ed93a832613364efb732004b44c10302b84d8039f758cec4d8ce2ace40"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.23/remem-linux-x64.tar.gz"
      sha256 "f661075980ad6a1b2342f98e87436df5080cddc2b17a72c433b42014303ed6aa"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.23/remem-linux-arm64.tar.gz"
      sha256 "3c2b8eebba3ba0485d29718e49069461cf495cc50c16ddbed8c8c2200489625f"
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
    assert_match "remem 0.6.23", shell_output("#{bin}/remem --version")
  end
end
