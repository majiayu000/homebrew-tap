# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.59"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.59/remem-darwin-x64.tar.gz"
      sha256 "932717b4e1a659eaac2b31ff5f037c3212f1c6c5946cb6422d5198ce8e6f4407"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.59/remem-darwin-arm64.tar.gz"
      sha256 "adaa5a4dde25279c3c7e97cedc8281fa6c9c45ab99fb5371da07280a067c1a5d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.59/remem-linux-x64.tar.gz"
      sha256 "c6b41fb061bbe3d45e765220db0035b80e07246471122ffc9e271000f3fae5cf"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.59/remem-linux-arm64.tar.gz"
      sha256 "2f0d60e9a94503e40a546958ef3d607426a971e2cdde4443e3fc9f203ae190fa"
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
    assert_match "remem 0.6.59", shell_output("#{bin}/remem --version")
  end
end
