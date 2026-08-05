# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.49"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.49/remem-darwin-x64.tar.gz"
      sha256 "2ea7fba0636ada3ceb9bc21f349280181b3b69cb4d3dfeaa1458cb37578d6917"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.49/remem-darwin-arm64.tar.gz"
      sha256 "efe8ea9b16a2bd4ad59d779d6542bdd7ce22df20fa96052bf5f9b82be1db87bb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.49/remem-linux-x64.tar.gz"
      sha256 "a8d5b48f8ddf41a4e39d58ef0128cefaf1c24f6dd6fe8fdd98dfb3680a153fef"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.49/remem-linux-arm64.tar.gz"
      sha256 "72faa8835551328a6461ab24f2eac771b58cd32a29dac2b362ccd9be1c61e2e8"
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
    assert_match "remem 0.6.49", shell_output("#{bin}/remem --version")
  end
end
