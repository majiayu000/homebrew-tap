# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.69"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.69/remem-darwin-x64.tar.gz"
      sha256 "34c1207bd187e41d190132807744090b64dd5a80c22da391f16a8a79b32b16ce"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.69/remem-darwin-arm64.tar.gz"
      sha256 "0677dbe2e604a84359ad1e36a3658dc7d03cc9ef4444a27ffb795def341c1f8c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.69/remem-linux-x64.tar.gz"
      sha256 "a7c3850cde3aea8d0c952e2f448d27d2cc1bf7fec0b7dc613256beeeac8d4b5c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.69/remem-linux-arm64.tar.gz"
      sha256 "40bd880b56e3d5a53e551786a3289e861acae19f9216f437b94b2e72edde4e74"
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
    assert_match "remem 0.6.69", shell_output("#{bin}/remem --version")
  end
end
