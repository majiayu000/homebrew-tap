class Ccstats < Formula
  desc "Fast Claude Code token usage statistics CLI"
  homepage "https://github.com/majiayu000/ccstats"
  url "https://crates.io/api/v1/crates/ccstats/0.1.18/download"
  sha256 "f1511ed3b93767a5264df803ec56a72b8ea1ce89148356f3814e78ace56c80bb"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ccstats", shell_output("#{bin}/ccstats --version")
  end
end
