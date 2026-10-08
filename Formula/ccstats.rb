class Ccstats < Formula
  desc "Fast Claude Code and OpenAI Codex usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://static.crates.io/crates/ccstats/ccstats-0.11.0.crate"
  sha256 "a6b2bd252c92ca62ca03980cbcb7505bdfb13d26571117df97c325793ffcf258"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
