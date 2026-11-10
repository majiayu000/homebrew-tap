# typed: false
# frozen_string_literal: true

# Rendered by .github/workflows/release.yml on every tagged release and
# pushed to majiayu000/homebrew-rclean. Edit the template in the rclean
# repo, not the generated formula in the tap.
class Rclean < Formula
  desc "Find and safely clean rebuildable developer artifacts"
  homepage "https://github.com/majiayu000/rclean"
  version "0.2.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/majiayu000/rclean/releases/download/v#{version}/rclean-cli-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "de4f8496fa5b0242101f4181231a6f5646108e1c1abe6db414f0b269c6a4120c"
    else
      url "https://github.com/majiayu000/rclean/releases/download/v#{version}/rclean-cli-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "3617306de72c63c4219dd9a519429f5894788cb9391ea303beca977ad2160b5e"
    end
  else
    url "https://github.com/majiayu000/rclean/archive/refs/tags/v#{version}.tar.gz"
    sha256 "ac758da85f5375de0f6fab50ff9e6d0299d38214f9fde3dd80862db7035abf34"
    depends_on "rust" => :build
  end

  def install
    if OS.linux?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "rclean"
    end
    generate_completions_from_executable(bin/"rclean", "completions")
    (buildpath/"rclean.1").write Utils.safe_popen_read(bin/"rclean", "man")
    man1.install "rclean.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rclean --version")
  end
end
