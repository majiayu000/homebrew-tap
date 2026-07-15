# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.206"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.206/remem-darwin-x64.tar.gz"
      sha256 "e97835968eebd3234d6a16e9313d12842f210af578830bb4ee422092a987eee6"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.206/remem-darwin-arm64.tar.gz"
      sha256 "00fb9f7df46c091d81e54d9435cf763db98fcd5e3d4ed502fe430123c6cc8ddf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.206/remem-linux-x64.tar.gz"
      sha256 "b42485dbd4b93c9cfd82420fa2b5fd55f1838175c7e145b5a967b6d651c004d8"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.206/remem-linux-arm64.tar.gz"
      sha256 "cb97ba46bb68e04fdd9f49a437a8d39f51b2fa250827d7a0325b150474c435e9"
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
    assert_match "remem 0.5.206", shell_output("#{bin}/remem --version")
  end
end
