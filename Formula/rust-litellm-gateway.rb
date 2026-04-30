class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.5.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.5.0/rust-litellm-gateway-v0.5.0-macos-aarch64.tar.gz"
    sha256 "962706d1741b4ac83d266cc0926660c849f372e431d9b62f73b76b12420486a3"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.5.0/rust-litellm-gateway-v0.5.0-macos-x86_64.tar.gz"
    sha256 "67a1e47608f9f2d1d21c8d0bfd35b9bfec155f523cf0ab7ddba087a547e48231"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
