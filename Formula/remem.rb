# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.70"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.70/remem-darwin-x64.tar.gz"
      sha256 "c52bdb0d2074874dd1772361a1888b618da66182a815f61a6ad7c35b225d58c4"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.70/remem-darwin-arm64.tar.gz"
      sha256 "2063dd3639bbef57c5b7aab927d5b460dcdfda7fd8284347cd70a18977b23486"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.70/remem-linux-x64.tar.gz"
      sha256 "170a4d336645ce42addace92a8c4c5bec575eab98b3be88112a6b424f8184378"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.70/remem-linux-arm64.tar.gz"
      sha256 "a7f267c729ba4c7ffda42efddf44104ff02ed379c032c186248c876a08ff7cd6"
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
    assert_match "remem 0.6.70", shell_output("#{bin}/remem --version")
  end
end
