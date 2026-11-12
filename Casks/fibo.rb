cask "fibo" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.2"
  sha256 arm:   "c5030dc031caa9e282c5ddcb2633096303715ed53d095d3279f71f468acdc500",
         intel: "c581050cfa67b5c1d4d87703b2ac15270a5d17c06c5a5d9d41f52e3cac939a46"

  url "https://github.com/majiayu000/fibo/releases/download/v#{version}/Fibo-#{version}-#{arch}.dmg",
      verified: "github.com/majiayu000/fibo/"
  name "Fibo"
  desc "Native workbench for coding agents"
  homepage "https://fibo.page/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Fibo.app"

  zap trash: [
    "~/.config/fibo",
    "~/.local/share/fibo-workbench",
    "~/Library/Caches/Fibo",
    "~/Library/Logs/Fibo",
    "~/Library/Preferences/page.fibo.app.plist",
  ]
end
