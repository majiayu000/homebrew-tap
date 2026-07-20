# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.12"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.12/remem-darwin-x64.tar.gz"
      sha256 "82b63fd9249a68edc4b1c85d8dd3773b6ca8f6b2c43a06eb9f4f0fd8c5a6afe7"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.12/remem-darwin-arm64.tar.gz"
      sha256 "bc1bae524e1e150bb104bfedc22281bde6e096974d2311228fd0ab860819d4a0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.12/remem-linux-x64.tar.gz"
      sha256 "de53c6f152f7f11f75ee2177846299cee9d346b46d976477268a384e979148bc"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.12/remem-linux-arm64.tar.gz"
      sha256 "723eb782d6f67a4029938d81dad902728209315be2dbd0ffffb6fa29f9dba864"
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
    assert_match "remem 0.6.12", shell_output("#{bin}/remem --version")
  end
end
