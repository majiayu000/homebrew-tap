cask "fibo" do
  version "0.1.0"
  sha256 "4ef1467d95b1e150a57e5f82dcd02e11ec0a68a9c76fc775f3e3a0ac773b12d6"

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
