# typed: false
# frozen_string_literal: true

class Clonewatch < Formula
  desc "Find non-fork GitHub copies of a repository that add malware archives"
  homepage "https://github.com/majiayu000/clonewatch"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/clonewatch/releases/download/v0.1.0/clonewatch-x86_64-apple-darwin.tar.gz"
      sha256 "7f533825f8501819d38ce0bf212d94eb3ec824266672bcc0c0e77245c50efab2"
    end
    on_arm do
      url "https://github.com/majiayu000/clonewatch/releases/download/v0.1.0/clonewatch-aarch64-apple-darwin.tar.gz"
      sha256 "04e26912d06352703759829d05635b4c6a310bd5f31fbcc79f0cb6f56976aa1c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/clonewatch/releases/download/v0.1.0/clonewatch-x86_64-unknown-linux-musl.tar.gz"
      sha256 "670f02b5353aadc87b4892d4424a58eeb363a0e8719eea0970e25ee2ecdea71b"
    end
  end

  def install
    bin.install "clonewatch"
  end

  test do
    assert_match "clonewatch 0.1.0", shell_output("#{bin}/clonewatch --version")
  end
end
