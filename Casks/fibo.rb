cask "fibo" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.4"
  sha256 arm:   "9259e07ae2a294279d00deafadceee16b0720d7f0b6b4a3e2c8a63059dfbec33",
         intel: "1a361f0883afddd771fe4272d622f02ae2246050d51dc09539b903ec660eeede"

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
