class Ccstats < Formula
  desc "Fast Claude Code and OpenAI Codex usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://static.crates.io/crates/ccstats/ccstats-0.4.0.crate"
  sha256 "84d13d823e3f9fa16bd0bcc11ebaf1e69ed24e1166442b4d2f8be8407b5a41a7"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
