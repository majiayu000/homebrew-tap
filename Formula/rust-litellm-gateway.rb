class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.7.0"
  license "MIT"

  depends_on :macos

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.7.0/rust-litellm-gateway-v0.7.0-macos-aarch64.tar.gz"
    sha256 "5bd9923e9248852d2042abb35b044faa2b41b2bd203820e2bd441c4de1e3f534"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.7.0/rust-litellm-gateway-v0.7.0-macos-x86_64.tar.gz"
    sha256 "02dfc29ffc54b73d17c7612d697a704d210d88e8e79ecc62c2d9aa44ce933d6a"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
