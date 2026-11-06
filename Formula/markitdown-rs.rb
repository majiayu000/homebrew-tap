# typed: false
# frozen_string_literal: true

class MarkitdownRs < Formula
  desc "Convert PDF, Office, HTML and EPUB files to Markdown for LLMs"
  homepage "https://github.com/majiayu000/markitdown-rs"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.1/markitdown-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "677556c2fd21099a0ee99f657d12d35981cf60fcec961f2dbf9fc69556df1e4d"
    end
    on_arm do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.1/markitdown-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "6ce699d932a9ed7b083871c79bc15c9f580289c8009cc7f37fe9435b08f6fe2e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.1/markitdown-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a332bbcfb4758702e199ec03f5383873cdbccba3dd98a388c0f7353c56857684"
    end
  end

  def install
    bin.install "markitdown"
  end

  test do
    assert_match "markitdown 0.2.1", shell_output("#{bin}/markitdown --version")
  end
end
