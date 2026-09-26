class Ccstats < Formula
  desc "Fast Claude Code and OpenAI Codex usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://static.crates.io/crates/ccstats/ccstats-0.9.0.crate"
  sha256 "0a275bc6c8b6c3cd5b7c846cfe5f314647bc5a4d58e4c4db57d33b8567314480"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
