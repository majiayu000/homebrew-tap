# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.9"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.9/remem-darwin-x64.tar.gz"
      sha256 "6acc7846e9525263d85912d365673b00d7227467467512f4dad1cf5696b741fd"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.9/remem-darwin-arm64.tar.gz"
      sha256 "51582f27050361823c27b4eed7ef244e17fc608dd588d7d7fedd0379e1686bda"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.9/remem-linux-x64.tar.gz"
      sha256 "534391113f7121029c857da9dbbe0331333d0c13a87e8458e2a32c73cb526663"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.9/remem-linux-arm64.tar.gz"
      sha256 "b0e534198389930f155f9332d78d84db915f285fbe9dc46f7702199bceb740c0"
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
    assert_match "remem 0.6.9", shell_output("#{bin}/remem --version")
  end
end
