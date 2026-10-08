class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  version "0.9.0"
  license "MIT"

  depends_on :macos

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.9.0/rust-litellm-gateway-v0.9.0-macos-aarch64.tar.gz"
    sha256 "c107bb5e8abc9a28ce8ce6e593474998c06f50bf5543a7d81aff2b88e9e9d9d9"
  elsif OS.mac?
    url "https://github.com/majiayu000/litellm-rs/releases/download/v0.9.0/rust-litellm-gateway-v0.9.0-macos-x86_64.tar.gz"
    sha256 "cd387f9a2762b8f88df9bff8506645252879220bd0b750febec259a163a53def"
  end

  def install
    bin.install "gateway"
  end

  test do
    assert_match "gateway #{version}", shell_output("#{bin}/gateway --version")
  end
end
