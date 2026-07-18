# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.7"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.7/remem-darwin-x64.tar.gz"
      sha256 "8114a3db479283cf140965d538dacae67c349a3d74d3fedc4ceea5870c060717"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.7/remem-darwin-arm64.tar.gz"
      sha256 "46d0630cda8380c73ad4161006d3bb73604cc2090fea20e5eca4255ba29adc2c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.7/remem-linux-x64.tar.gz"
      sha256 "8c90ee84a105d790028963efbc6e4d1b5d480019b053cf434c96a521e7402e83"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.7/remem-linux-arm64.tar.gz"
      sha256 "d282448fd57cef6fff2015e732ea0d6527dafb1d305b3fb97c14812f7552529b"
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
    assert_match "remem 0.6.7", shell_output("#{bin}/remem --version")
  end
end
