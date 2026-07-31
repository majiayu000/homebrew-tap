# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.6.39"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.39/remem-darwin-x64.tar.gz"
      sha256 "85de686375a81421ac48c32db716fdbeff421040603d0d9602c342be843c5685"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.39/remem-darwin-arm64.tar.gz"
      sha256 "759d101657996e1d0ae8b770468db481fddfd28d33365154c2bd7a429f8a0bb0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.39/remem-linux-x64.tar.gz"
      sha256 "271d1802204494caabb3c85cddc524ebff86340ad8aaadff9b9904dded61d7d7"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.6.39/remem-linux-arm64.tar.gz"
      sha256 "407a610fb5a90b7b9a6d72c7840419c86bfccf606679ef3d3b49ce7c8485851c"
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
    assert_match "remem 0.6.39", shell_output("#{bin}/remem --version")
  end
end
