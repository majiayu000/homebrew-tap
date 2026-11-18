cask "fibo" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.3"
  sha256 arm:   "659d0681e0f92db367080b1dc7299e9be214651f6826df4fd82ae071d66a16a2",
         intel: "ec01f848ba346ac1747dd3f0e203c880b4fb39b62cae520201c0b58fd786d34d"

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
