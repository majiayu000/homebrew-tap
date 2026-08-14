# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.74"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.74/remem-darwin-x64.tar.gz"
      sha256 "bf09a1501ee23f8b9e39b739bb9b80be58ca04b212ea62399832235144a14778"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.74/remem-darwin-arm64.tar.gz"
      sha256 "0f144aa2e9c522c53c7474a0af12ba1ebd02edb3c870a0e2e3ff99119f291458"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.74/remem-linux-x64.tar.gz"
      sha256 "b3c7ee137ccbc2bd89333d7e807724f5dbc4b2f6ae5e6b8ce99ddfe4966606e5"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.74/remem-linux-arm64.tar.gz"
      sha256 "50fedcef4b09272b9efdc863ee3c89977e921a3ae41cfad554e5405f3e98e314"
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
    assert_match "remem 0.6.74", shell_output("#{bin}/remem --version")
  end
end
