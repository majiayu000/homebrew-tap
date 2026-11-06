# typed: false
# frozen_string_literal: true

class BbhostCheck < Formula
  desc "Find Bitbucket SSH remotes and configs that need migrating"
  homepage "https://github.com/majiayu000/bbhost-check"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.1/bbhost-check-x86_64-apple-darwin.tar.gz"
      sha256 "cc19fc5004972ffc64016f9d4d20e94eabea9ab93905fa48dc233b8cc042dcaa"
    end
    on_arm do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.1/bbhost-check-aarch64-apple-darwin.tar.gz"
      sha256 "12dd583b514b28372782a000936cfaa35fd56c86e73cc39e0441311dcec0db23"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/bbhost-check/releases/download/v0.1.1/bbhost-check-x86_64-unknown-linux-musl.tar.gz"
      sha256 "658ad811436cbb7f4e7bfa32173bbb7993a1a18705d1be65aa2acaeca374176c"
    end
  end

  def install
    bin.install "bbhost-check"
  end

  test do
    assert_match "bbhost-check 0.1.1", shell_output("#{bin}/bbhost-check --version")
  end
end
