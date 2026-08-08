# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.60"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.60/remem-darwin-x64.tar.gz"
      sha256 "94f31ba0be3523d62ec9553253e72cacd28848191d76114c936bcc0b83a89709"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.60/remem-darwin-arm64.tar.gz"
      sha256 "637ad90194e59ddc1aaae2ba047f02a18ec7d68ef3fb9994354b5b1d7c1551ed"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.60/remem-linux-x64.tar.gz"
      sha256 "60d2715bcfad8beb8a7023127e6804718775e6b7dece91a3ca4bf56114af4f2f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.60/remem-linux-arm64.tar.gz"
      sha256 "53c9bfcb7867e36afc71f97029813e26b764399456812caabe7bd945b95af4c8"
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
    assert_match "remem 0.6.60", shell_output("#{bin}/remem --version")
  end
end
