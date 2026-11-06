# typed: false
# frozen_string_literal: true

class Trustsweep < Formula
  desc "Find bundled CA stores that still trust revoked certificate authorities"
  homepage "https://github.com/majiayu000/trustsweep"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/trustsweep/releases/download/v0.2.1/trustsweep-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "652a395c432200e439ad701e8f27662c8364a1c1b223e979121422186870e6f9"
    end
    on_arm do
      url "https://github.com/majiayu000/trustsweep/releases/download/v0.2.1/trustsweep-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "b53338a8bce74872d06b7d83441bf6adcc93c4e7e7130ac5f58b47b29ccbf9d0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/trustsweep/releases/download/v0.2.1/trustsweep-v0.2.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "45769940bb7a0807695f463b3fae964cb27040524bb06d3f28685f461c9f3998"
    end
  end

  def install
    bin.install "trustsweep"
  end

  test do
    assert_match "trustsweep 0.2.1", shell_output("#{bin}/trustsweep --version")
  end
end
