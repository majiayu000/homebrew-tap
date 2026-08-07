# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.54"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.54/remem-darwin-x64.tar.gz"
      sha256 "93e96d948674e3c9fd6f431c150fb9529c30dabc8eb106020b46bef90def87a2"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.54/remem-darwin-arm64.tar.gz"
      sha256 "c1e4eedadf893d026be94d8cda0fa4c4b151b1eaaab7f2ce275f1e8f236d6cd3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.54/remem-linux-x64.tar.gz"
      sha256 "c1d1e058052297c54ff73acf1b97523deb6ed518f0cd6e1894e1800ca7b3fc93"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.54/remem-linux-arm64.tar.gz"
      sha256 "2eae8b502dd763a9218ab8796168eedfc845f2ca745020144f637a4c9f40049a"
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
    assert_match "remem 0.6.54", shell_output("#{bin}/remem --version")
  end
end
