# typed: false
# frozen_string_literal: true

class BbhostCheck < Formula
  desc "Find Bitbucket SSH remotes and configs that need migrating"
  homepage "https://github.com/majiayu000/bbhost-check"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.0/bbhost-check-x86_64-apple-darwin.tar.gz"
      sha256 "58b10730c20db5e6218901fed9f0fcfe7a81fa48b91833ce5a9875782aee04ac"
    end
    on_arm do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.0/bbhost-check-aarch64-apple-darwin.tar.gz"
      sha256 "309b4fb49e6d4c47ea26e5abc2279f3cd6f178864235c56d2acf13b88edfacfe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.0/bbhost-check-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3977eda2405c1556a718adaed1d6d978ff5455b11c26375c28cd758735727ea7"
    end
  end

  def install
    bin.install "bbhost-check"
  end

  test do
    assert_match "bbhost-check 0.1.0", shell_output("#{bin}/bbhost-check --version")
  end
end
