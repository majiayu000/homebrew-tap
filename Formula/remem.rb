# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.78"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.78/remem-darwin-x64.tar.gz"
      sha256 "ea9b5b6137d284a4d6277271e09bd80da54a7779322b722abef82a38ad24a1a1"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.78/remem-darwin-arm64.tar.gz"
      sha256 "35d1f3f166efbcfc745288bfd30d2f1fed89ce77d5ffbc3d125f56c9f94c84fc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.78/remem-linux-x64.tar.gz"
      sha256 "07252577af1feb1e885160dd6ceb4795f0a7df8ec96b6c0156a38ebf28cd2aa1"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.78/remem-linux-arm64.tar.gz"
      sha256 "2407216b78b27c3f60add5429c8fb32d486e5a044380cdbd4eab16a90bde07a8"
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
    assert_match "remem 0.6.78", shell_output("#{bin}/remem --version")
  end
end
