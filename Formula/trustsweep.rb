# typed: false
# frozen_string_literal: true

class Trustsweep < Formula
  desc "Find bundled CA stores that still trust revoked certificate authorities"
  homepage "https://github.com/majiayu000/trustsweep"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/trustsweep/releases/download/v0.2.0/trustsweep-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "203901d2b5f0c691fe016860157eaeea0a82f272e264f501260d155a712d6a10"
    end
    on_arm do
      url "https://github.com/majiayu000/trustsweep/releases/download/v0.2.0/trustsweep-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "34aa5e6ffbf80b40f4ea2f8a0c4dc43d57b00be4201fa441a6a734d19299741b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/trustsweep/releases/download/v0.2.0/trustsweep-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0755971f3b2968df7001114b7865e973f826fcb01eadac118d79e31696b3f472"
    end
  end

  def install
    bin.install "trustsweep"
  end

  test do
    assert_match "trustsweep 0.2.0", shell_output("#{bin}/trustsweep --version")
  end
end
