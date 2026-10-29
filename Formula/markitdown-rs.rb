# typed: false
# frozen_string_literal: true

class MarkitdownRs < Formula
  desc "Convert PDF, Office, HTML and EPUB files to Markdown for LLMs"
  homepage "https://github.com/majiayu000/markitdown-rs"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.0/markitdown-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "9e9369570f230e3273be6f7189560ce1295c33f1dba3b815c78dcbdc076d4264"
    end
    on_arm do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.0/markitdown-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "bb935d668e65e9fc60223e5ac8c3e5cfd9bddbf9eee92dd84949e8401016a834"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/markitdown-rs/releases/download/v0.2.0/markitdown-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "04c33583b300b28b22250f1a10a71a27ba9e875a098f72b4c1579102cc7ed1ca"
    end
  end

  def install
    bin.install "markitdown"
  end

  test do
    assert_match "markitdown 0.2.0", shell_output("#{bin}/markitdown --version")
  end
end
