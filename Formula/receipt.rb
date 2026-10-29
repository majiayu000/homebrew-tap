# typed: false
# frozen_string_literal: true

class Receipt < Formula
  desc "Stop hook that blocks unproven completion claims from coding agents"
  homepage "https://github.com/majiayu000/receipt"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/receipt/releases/download/v0.2.0/receipt-x86_64-apple-darwin.tar.gz"
      sha256 "8fb1a82b12ad2c807db306793c20a5d5103426df1463120b90022910907f4972"
    end
    on_arm do
      url "https://github.com/majiayu000/receipt/releases/download/v0.2.0/receipt-aarch64-apple-darwin.tar.gz"
      sha256 "811edffda6f98ba27e9f973c73714cbffa20218e77ae5a99bd6346da1a0e1177"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/receipt/releases/download/v0.2.0/receipt-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "89682991e38e32139caed10459f755d7ef52e5740a9ce9809c3f98e0a636ccc7"
    end
  end

  def install
    bin.install "receipt"
  end

  test do
    assert_match "receipt 0.2.0", shell_output("#{bin}/receipt --version")
  end
end
