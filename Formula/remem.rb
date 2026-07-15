# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.5.208"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.208/remem-darwin-x64.tar.gz"
      sha256 "7ad3739c397cf13122b6d5580bde9438181653deb54d5f3f2903b44ebe9e29e2"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.208/remem-darwin-arm64.tar.gz"
      sha256 "d78a661fea8437452ded013647c17794a4165185d2f652782f323abf9dbb6f46"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.208/remem-linux-x64.tar.gz"
      sha256 "8eea962b74b6ef1a0c12b8c0268958e6d7ea3bccc80c6d5ce1b90b1bf65c0650"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.5.208/remem-linux-arm64.tar.gz"
      sha256 "1bbca454026afc8bace6019945bbd8e189c63fc33f1c26cff01f72e2b52319c3"
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
    assert_match "remem 0.5.208", shell_output("#{bin}/remem --version")
  end
end
