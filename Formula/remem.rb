# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.88"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.88/remem-darwin-x64.tar.gz"
      sha256 "3b15da1fc1cdc18394073fc8c12afa431ec61592b61eca4a4af9c3ab215c1d6b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.88/remem-darwin-arm64.tar.gz"
      sha256 "e626f3c4f38a16bf9950c1ce47b48b4378864bf75021d67c9c888a0d8a098b4b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.88/remem-linux-x64.tar.gz"
      sha256 "ee3949e3f74b1427239fee95b6ad0578bfdf03a0993730fe9427dff524b23bd5"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.88/remem-linux-arm64.tar.gz"
      sha256 "9ac9d666b6087615ad24f41bf2ae9f9c1415351067dc88ac90bce39548ad4668"
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
    assert_match "remem 0.6.88", shell_output("#{bin}/remem --version")
  end
end
