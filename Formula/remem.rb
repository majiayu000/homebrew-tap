# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.16"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.16/remem-darwin-x64.tar.gz"
      sha256 "e44a881518faa044ff660f56891e0e3063cf0738c661f1cf9da29989d40fed8f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.16/remem-darwin-arm64.tar.gz"
      sha256 "497e5955b99447394ff29a14222edc3378df18be78391313d0761ef626dbaa22"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.16/remem-linux-x64.tar.gz"
      sha256 "0f8abf84dd8523333c9231ba5122ddcf7ed971f8b7f5d1412ad24099170088ee"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.16/remem-linux-arm64.tar.gz"
      sha256 "bc4c39cd3d9381b450c4b5056b0f19c8e08419b2a75c8c455e3c5352eb864cf2"
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
    assert_match "remem 0.6.16", shell_output("#{bin}/remem --version")
  end
end
