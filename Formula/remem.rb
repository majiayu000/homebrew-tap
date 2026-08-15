# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.75"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.75/remem-darwin-x64.tar.gz"
      sha256 "9573b2cf90ef9608af4e1b1bca03cd603b28a7a2edd16e91b62722b23d07e3bd"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.75/remem-darwin-arm64.tar.gz"
      sha256 "98470bf2e017b796fba71656574ac2817679a214f80e60093d20ccda0fc43ea7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.75/remem-linux-x64.tar.gz"
      sha256 "f63408393980254e05e4955bb3b9da37fa10f7dae9cd04b8c89fc0fd5b5443ee"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.75/remem-linux-arm64.tar.gz"
      sha256 "05e96f011335554856bafeb747b004fc992c165156d182b43a92695d3ad64084"
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
    assert_match "remem 0.6.75", shell_output("#{bin}/remem --version")
  end
end
