# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.56"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.56/remem-darwin-x64.tar.gz"
      sha256 "4988acc250b2359782bbee3e4807999e83f1807471958c7b1bd7007a15fd5597"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.56/remem-darwin-arm64.tar.gz"
      sha256 "45891848f88f4dc189e5db0f9f6bba7765ad9a6cf3a4aaba38ac5784ee59facb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.56/remem-linux-x64.tar.gz"
      sha256 "1dde341454aed350d608d8c56556492e9b1fc092e1a2bff8953eae3f6472f8bf"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.56/remem-linux-arm64.tar.gz"
      sha256 "b2b24b48f17774e4a04eae12482689a649cadde82e625dc5cf1bae4e5f40eb28"
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
    assert_match "remem 0.6.56", shell_output("#{bin}/remem --version")
  end
end
