class Ccstats < Formula
  desc "Fast Claude Code and OpenAI Codex usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://crates.io/api/v1/crates/ccstats/0.2.58/download"
  sha256 "6122668f97359d5c9481809bb82a4957f765f73020f26081b9b2d24e8136d62a"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
