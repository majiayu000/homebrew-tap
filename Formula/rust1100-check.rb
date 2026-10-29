# typed: false
# frozen_string_literal: true

class Rust1100Check < Formula
  desc "Find CI configs and scripts that misread Rust 1.100 as Rust 1.1"
  homepage "https://github.com/majiayu000/rust1100-check"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/rust1100-check/releases/download/v0.2.0/cargo-rust1100-check-x86_64-apple-darwin.tar.gz"
      sha256 "8c43041a870c5a8a652fa1888416d624717404587a9afc8592011a174dd193e9"
    end
    on_arm do
      url "https://github.com/majiayu000/rust1100-check/releases/download/v0.2.0/cargo-rust1100-check-aarch64-apple-darwin.tar.gz"
      sha256 "b9acb4a5ba34f1aa619b58e53e619350474e50b49dd95651f1204efb9d1a35f8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/rust1100-check/releases/download/v0.2.0/cargo-rust1100-check-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "353283214367573579c844922d545110bd3c130d0523f956e395885e518ad172"
    end
  end

  def install
    bin.install "cargo-rust1100-check"
  end

  test do
    assert_match "cargo-rust1100-check 0.2.0", shell_output("#{bin}/cargo-rust1100-check --version")
  end
end
