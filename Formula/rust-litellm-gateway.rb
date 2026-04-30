class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.5.0"
  license "MIT"

  depends_on :macos

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.5.0/rust-litellm-gateway-v0.5.0-macos-aarch64.tar.gz"
    sha256 "24cd11a2e85c5574fe6eb79002593e8e4bfc5130de4ad15b0e5520b366e2bb01"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.5.0/rust-litellm-gateway-v0.5.0-macos-x86_64.tar.gz"
    sha256 "69f240a19fe28957cfe5ce11abe4c944ce8ea13b0a5be94582682506a76d270e"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
