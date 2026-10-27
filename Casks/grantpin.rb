cask "grantpin" do
  version "0.2.2"
  sha256 "37f275f948893cd1a0d5c78f3e34abc6983a379de6cfa81acffac92e44d78370"

  url "https://github.com/jmeh-sindikata/grantpin/releases/download/v#{version}/grantpin-#{version}.dmg"
  name "grantpin"
  desc "Local secrets broker for AI coding agents"
  homepage "https://grantpin.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "grantpin.app"
  binary "#{appdir}/grantpin.app/Contents/Helpers/grantpin-daemon.app/Contents/MacOS/grantpin"

  uninstall launchctl: "dev.grantpin.daemon",
            quit:      "dev.grantpin.app"

  zap trash: [
    "~/Library/Application Support/grantpin",
    "~/Library/LaunchAgents/dev.grantpin.daemon.plist",
    "~/Library/Logs/grantpin",
    "~/Library/Preferences/dev.grantpin.app.plist",
  ]

  caveats <<~EOS
    Open grantpin from Applications once to create the vault and install the
    background service.

    `brew uninstall --zap` deletes the vault with all your secrets.

    The Secure Enclave key in the Keychain is removed only by the app's own
    Settings > Uninstall.
  EOS
end
