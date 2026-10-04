class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.8.2"
  license "MIT"

  depends_on :macos

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.8.2/rust-litellm-gateway-v0.8.2-macos-aarch64.tar.gz"
    sha256 "22bcdfe1c8ffa207cacfba256994a029c181c9072233bc2d69d6371d8083190b"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.8.2/rust-litellm-gateway-v0.8.2-macos-x86_64.tar.gz"
    sha256 "e19fd47ec83694306a147223950d73e2b49c22b91b855ab05eb1ce2463026cf2"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
