class Ccstats < Formula
  desc "Fast Claude Code and OpenAI Codex usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://crates.io/api/v1/crates/ccstats/0.2.62/download"
  sha256 "a176e18569072dded63c17301a8816d9f18a11d237e550d86aec20e5e9f7add6"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
