cask "caff" do
  version "0.1.5"
  sha256 "761cb93e62249967dcfc599b7f13029d77b9d05b16ab7ae337fa2b0d5c17a263"

  url "https://github.com/majiayu000/caff/releases/download/v#{version}/Caff-#{version}.zip"
  name "Caff"
  desc "Menu bar app that keeps the machine awake during long-running agent tasks"
  homepage "https://github.com/majiayu000/caff"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Caff.app"

  uninstall quit: "com.starlight.caff"

  zap trash: [
    "~/Library/Application Support/Caff",
    "~/Library/Preferences/com.starlight.caff.plist",
  ]
end
