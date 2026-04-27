class RustLitellmGateway < Formula
  desc "High-performance AI gateway with OpenAI-compatible APIs"
  homepage "https://github.com/majiayu000/litellm-rs"
  url "https://crates.io/api/v1/crates/litellm-rs/0.4.16/download"
  sha256 "aa22a5e8638de81bfc989d13754e300eb6cdddff22e4732f0ebed7e5e88a1170"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_path_exists bin/"gateway"
    assert_path_exists bin/"google-gateway"
    assert_match "Pricing Management Tool 1.0", shell_output("#{bin}/pricing-tool --version")
  end
end
