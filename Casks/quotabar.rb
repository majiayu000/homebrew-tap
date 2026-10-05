cask "quotabar" do
  arch arm: "aarch64", intel: "x64"

  version "0.5.9"
  sha256 arm:   "8a5bfb1740bf53c0a16ede2b66e3682a6a1be7c697019b3256b08bda404af442",
         intel: "6c0b67d6eda0b92e0380760fbe2539143c1908d7596c245b4e428dbc1fe21435"

  url "https://github.com/majiayu000/quotabar/releases/download/v#{version}/QuotaBar_#{version}_#{arch}.dmg"
  name "QuotaBar"
  desc "Menu bar monitor for AI coding assistant quotas"
  homepage "https://github.com/majiayu000/quotabar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "QuotaBar.app"

  zap trash: [
    "~/Library/Application Support/quotabar",
    "~/Library/Caches/com.starlight.quotabar",
    "~/Library/Caches/quotabar",
    "~/Library/LaunchAgents/QuotaBar.plist",
    "~/Library/Logs/quotabar",
    "~/Library/Preferences/com.starlight.quotabar.plist",
    "~/Library/WebKit/com.starlight.quotabar",
  ]
end
