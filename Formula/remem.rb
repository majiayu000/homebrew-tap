# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.50"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.50/remem-darwin-x64.tar.gz"
      sha256 "74ddc7b58cf07a0f109c585c2ed60264715f666bf21b754bd695513ed2d67625"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.50/remem-darwin-arm64.tar.gz"
      sha256 "ab7fe43866ddf55f8c902c66868a6bd20920e8f3f87973117160413f42e4f99b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.50/remem-linux-x64.tar.gz"
      sha256 "c14b768ec3ac59936f88b49a794193d38ff843caa8499eadaf22d381139a042c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.50/remem-linux-arm64.tar.gz"
      sha256 "fc1909748818c688653eef444fbfddb543d85554d07eb5f97f1133e7abe88831"
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
    assert_match "remem 0.6.50", shell_output("#{bin}/remem --version")
  end
end
