class Ccstats < Formula
  desc "Fast Claude Code and OpenAI Codex usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://static.crates.io/crates/ccstats/ccstats-0.5.2.crate"
  sha256 "1cd0edf930f89b4d81282c321e8a7227afa5c1e541531b4be981d6b0b62dc20e"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
