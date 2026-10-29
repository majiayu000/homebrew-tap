# typed: false
# frozen_string_literal: true

class Exposewatch < Formula
  desc "Find exposed Docker containers running actively exploited versions"
  homepage "https://github.com/majiayu000/exposewatch"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/exposewatch/releases/download/v0.1.0/exposewatch-x86_64-apple-darwin.tar.gz"
      sha256 "dc3e85ab44ecb0c4385956c679d7dbc87cfe9f387ff34a26fcdb332861dc67c7"
    end
    on_arm do
      url "https://github.com/majiayu000/exposewatch/releases/download/v0.1.0/exposewatch-aarch64-apple-darwin.tar.gz"
      sha256 "d05c5fa92fe2b9f49e0151c9ad51822a980edf8b8b830520b69342002ef9cf02"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/exposewatch/releases/download/v0.1.0/exposewatch-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a303a49b288129bcc61c4402a0ec0adbf6e563d089f6a562d2652c5aea20a701"
    end
  end

  def install
    bin.install "exposewatch"
  end

  test do
    assert_match "exposewatch 0.1.0", shell_output("#{bin}/exposewatch --version")
  end
end
