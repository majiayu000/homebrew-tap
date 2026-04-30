class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.5.0"
  license "MIT"

  depends_on :macos

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.5.0/rust-litellm-gateway-v0.5.0-macos-aarch64.tar.gz"
    sha256 "804894fbec45937dc7fe192377b9440fbddacbfa6f9225f78a40474b967c930a"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.5.0/rust-litellm-gateway-v0.5.0-macos-x86_64.tar.gz"
    sha256 "9ef39b0d873dd82cd4b7894f2185974b0f8db1dcf2147483561611afbd381705"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
