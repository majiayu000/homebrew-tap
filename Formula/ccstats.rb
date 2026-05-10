class Ccstats < Formula
  desc "Fast Claude Code and OpenAI Codex usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://static.crates.io/crates/ccstats/ccstats-0.2.63.crate"
  sha256 "7e157bd341472d46bc54c90faa50763b42cce3f4bde31140fa1d2d74dd6153a5"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
