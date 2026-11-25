# typed: false
# frozen_string_literal: true

class MarkitdownRs < Formula
  desc "Convert PDF, Office, HTML and EPUB files to Markdown for LLMs"
  homepage "https://github.com/majiayu000/markitdown-rs"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.2/markitdown-v0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "322b7c020cf829fee99cf58d9f88d7d2a1c29325061232dcb130637e2cf9d19a"
    end
    on_arm do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.2/markitdown-v0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "5dec575af8090032bbb4ebe63603df8a2ca8588995a0c597c869c32b5f3e07ed"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.2/markitdown-v0.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "47dca47b3554e98a843c2fa23b7b0255d3d6cc3aca36575f780029898c5e7ba9"
    end
  end

  def install
    bin.install "markitdown"
  end

  test do
    assert_match "markitdown 0.2.2", shell_output("#{bin}/markitdown --version")
  end
end
