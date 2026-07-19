# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.11"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.11/remem-darwin-x64.tar.gz"
      sha256 "e828f35ad4a297ab359a5f3acb5308cd7ce767a695e643cec4ae6574bf196e97"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.11/remem-darwin-arm64.tar.gz"
      sha256 "b7e73e1ee8adb44d174b1d64c0e886a550d957a07047629cbb6d48d64af6d653"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.11/remem-linux-x64.tar.gz"
      sha256 "76f743c5f902540e917700f1551f554a876fef651c81fd7d1447ab4a9cda8089"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.11/remem-linux-arm64.tar.gz"
      sha256 "b805bd720aabf403e442ed8eb8c7a180f884041ea713a3a430c1834d0c47887c"
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
    assert_match "remem 0.6.11", shell_output("#{bin}/remem --version")
  end
end
