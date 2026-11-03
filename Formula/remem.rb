# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.0/remem-darwin-x64.tar.gz"
      sha256 "a15e574d62c6e91b48472056eb1acc13ce6b71d79fdc5d8e86d6f7ebc330341c"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.0/remem-darwin-arm64.tar.gz"
      sha256 "45b94edc83b8d7f8002f753bd8b3f90ac00514d3d9d4d2d4e50c4967904fe17b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.0/remem-linux-x64.tar.gz"
      sha256 "784c0a5774fdcce8cf93280c4fc91d17f071b29d8bb89ad723560fbff47d9a8f"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.7.0/remem-linux-arm64.tar.gz"
      sha256 "98019f4d25a3d729c920d34aef01bb7c74129214819df9c53864538604342490"
    end
  end

  def install
    bin.install "remem" => "remem"
    if OS.mac? && Hardware::CPU.arm?
      unless quiet_system "codesign", "--verify", bin/"remem"
        system "codesign", "--force", "--sign", "-", bin/"remem"
      end
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
    assert_match "remem 0.7.0", shell_output("#{bin}/remem --version")
  end
end
