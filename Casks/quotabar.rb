cask "quotabar" do
  arch arm: "aarch64", intel: "x64"

  version "0.7.4"
  sha256 arm:   "ba62ecbfea23acd0fb2edd84e2bc378de2345a9082981cffff41223b60d856b5",
         intel: "0f0b41ca19a7af0e91e1b3a49f800db252e87ba447966cdd5b1190656c44c675"

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
