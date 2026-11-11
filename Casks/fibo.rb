cask "fibo" do
  version "0.1.1"
  sha256 "687724ff6a63a0a2a97743321cdb0a5b938fc9e80a6da997cdf57f233be234a4"

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
