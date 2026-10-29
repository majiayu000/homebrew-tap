cask "quotabar" do
  arch arm: "aarch64", intel: "x64"

  version "0.6.0"
  sha256 arm:   "1d4f4259605928376f289d1e11bf702f5ee2b6104bb7b112e4b1409f7b298ad9",
         intel: "399af95558329c6aadbc36738c3be310c487abfa809aeb24903406e156992ff0"

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
