# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.62"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.62/remem-darwin-x64.tar.gz"
      sha256 "c34022aea285065273c6128acc23b74bcd5f5a129872a210b35f3750e60acca4"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.62/remem-darwin-arm64.tar.gz"
      sha256 "4bae2fc509d6d5d6580ed9764363efd47b0862e47936b10f7cde5ad877185fe5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.62/remem-linux-x64.tar.gz"
      sha256 "90f6b702f6f72c79f87bbbfc9174a4aa62e9f030567210fdeb607fc914ea79a9"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.62/remem-linux-arm64.tar.gz"
      sha256 "7e8a640d96c71b66c819e9f71db240caf24e2d7469207989b2e60c8b9d490b61"
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
    assert_match "remem 0.6.62", shell_output("#{bin}/remem --version")
  end
end
