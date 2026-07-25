# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.25"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.25/remem-darwin-x64.tar.gz"
      sha256 "f02afbd0e8209e57c9c22c0483886f112d91263f03c446d37f0229a3ebd08ff5"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.25/remem-darwin-arm64.tar.gz"
      sha256 "27ff1b0a5acd77525f22e6d529753b51be11d543985536d951063d374747afa1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.25/remem-linux-x64.tar.gz"
      sha256 "1ce294baeac1395ff80520abcce471b2f84a5768d99545a6c68b89c9d64026eb"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.25/remem-linux-arm64.tar.gz"
      sha256 "d182f61cc58ca442f26899576386a2dc42f38788cf82de125e64567239007a5b"
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
    assert_match "remem 0.6.25", shell_output("#{bin}/remem --version")
  end
end
