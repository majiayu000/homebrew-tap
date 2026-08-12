class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.6.0"
  license "MIT"

  depends_on :macos

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.6.0/rust-litellm-gateway-v0.6.0-macos-aarch64.tar.gz"
    sha256 "d41773272bd9cb851a27c96775bb5e9db8f45c2200b340aad159b929b7620bfb"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.6.0/rust-litellm-gateway-v0.6.0-macos-x86_64.tar.gz"
    sha256 "a94ab49e29c83043da63b3964536499b3a9f0dcae5b3cf9b206397f1cccfbd19"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
