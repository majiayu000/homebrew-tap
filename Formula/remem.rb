# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.72"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.72/remem-darwin-x64.tar.gz"
      sha256 "0a94a0cb72a35e5af7ec7d70b427672496d653ce271c81311b0d7f954499ff7b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.72/remem-darwin-arm64.tar.gz"
      sha256 "7227f759bb19f5d8c914e172681d7effd44bd6d2d44e409421158d4c4ac4938f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.72/remem-linux-x64.tar.gz"
      sha256 "b69f403eb75094e443803bc86f216611b1139b31b35da8ea0832f35117f3ccac"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.72/remem-linux-arm64.tar.gz"
      sha256 "29700271d36d2f01a51537e4e4bac83babd99bb03b6aaec0687c1cf26e4c1c9a"
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
    assert_match "remem 0.6.72", shell_output("#{bin}/remem --version")
  end
end
