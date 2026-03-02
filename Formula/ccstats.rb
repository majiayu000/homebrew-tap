class Ccstats < Formula
  desc "Fast Claude Code and OpenAI Codex usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://crates.io/api/v1/crates/ccstats/0.2.57/download"
  sha256 "c5a324ce0df8320ceed9dc02e6b6b5255db53dad6813446bd7f3688f542e810b"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
