class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.10.0"
  license "MIT"

  depends_on :macos

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.10.0/rust-litellm-gateway-v0.10.0-macos-aarch64.tar.gz"
    sha256 "723e8308e64bca1dff43bfc70a10d8fc4e2b9ca1d3b264a10ccac47ed41a50a6"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.10.0/rust-litellm-gateway-v0.10.0-macos-x86_64.tar.gz"
    sha256 "8e824910b29e2a2d13c0bdcebe3a01413c71c1a7f8f3934ea1fc948d3d7c3335"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
