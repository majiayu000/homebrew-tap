# typed: false
# frozen_string_literal: true

class BbhostCheck < Formula
  desc "Find Bitbucket SSH remotes and configs that need migrating"
  homepage "https://github.com/majiayu000/bbhost-check"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.2/bbhost-check-x86_64-apple-darwin.tar.gz"
      sha256 "eebcbc25d534cd35a2f2e943f039938ebc2a274ad47c552d3678513aa23b3a14"
    end
    on_arm do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.2/bbhost-check-aarch64-apple-darwin.tar.gz"
      sha256 "3f12dd2ba00a114c99792ba334ff4f95473f4c1563a87c2a16d0c21c8245a30f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.2/bbhost-check-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9403458b62679efd3fc5146283b9266d13ad418d8d1ad980acb1dd77eaa47bd2"
    end
  end

  def install
    bin.install "bbhost-check"
  end

  test do
    assert_match "bbhost-check 0.1.2", shell_output("#{bin}/bbhost-check --version")
  end
end
