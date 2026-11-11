cask "fibo" do
  version "0.2.0"
  sha256 "b5bf82fd9b5901e9acb4c953c9624dd44457f3b69fc3f3d6cba251166d8565a2"

  url "https://github.com/majiayu000/fibo/releases/download/v#{version}/Fibo-#{version}-arm64.dmg",
      verified: "github.com/majiayu000/fibo/"
  name "Fibo"
  desc "Native workbench for coding agents"
  homepage "https://fibo.page/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
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
