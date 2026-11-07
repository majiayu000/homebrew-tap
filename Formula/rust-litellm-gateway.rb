class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.10.1"
  license "MIT"

  depends_on :macos

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.10.1/rust-litellm-gateway-v0.10.1-macos-aarch64.tar.gz"
    sha256 "f18089d97bead0576d5800a428fadc481479d5f70250e061d1c0d5184b0125ad"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.10.1/rust-litellm-gateway-v0.10.1-macos-x86_64.tar.gz"
    sha256 "0c0ad604dc612276d690b6a4ffdaf35bfdc928c4341a4650133160104d4d0929"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
