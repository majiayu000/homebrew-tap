# typed: false
# frozen_string_literal: true

class Remem < Formula
  desc "Persistent memory for Claude Code and Codex"
  homepage "https://github.com/majiayu000/remem"
  version "0.4.5"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.4.5/remem-darwin-x64.tar.gz"
      sha256 "71d13ddd4935dd9e13e37c8ec1ff081934fb7a12c1d83c6c7b9b425a7acaab4d"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.4.5/remem-darwin-arm64.tar.gz"
      sha256 "35ffef27827c66e96c60149524c20e3af572c75f8f5d597eb740906f97255c22"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/remem/releases/download/v0.4.5/remem-linux-x64.tar.gz"
      sha256 "91106ddecc684ab223f343caf089312ca61a39c42e323ea5c6ea57fb82e5100b"
    end
    on_arm do
      url "https://github.com/majiayu000/remem/releases/download/v0.4.5/remem-linux-arm64.tar.gz"
      sha256 "27ac660646801aa14d89cfcab4fc626d6dbb7992dfc43a4e9000fbd971a4dc61"
    end
  end

  def install
    bin.install "remem"
  end

  test do
    assert_match "remem 0.4.5", shell_output("#{bin}/remem --version")
  end
end
