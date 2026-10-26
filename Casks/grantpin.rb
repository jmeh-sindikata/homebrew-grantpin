cask "grantpin" do
  version "0.2.1"
  sha256 "9f37b191615a13670881d9340d5e7675b1aa809e5889923f6313090dc6998b11"

  url "https://github.com/jmeh-sindikata/grantpin/releases/download/v#{version}/grantpin-#{version}.dmg"
  name "grantpin"
  desc "Local secrets broker for AI coding agents"
  homepage "https://jmeh-sindikata.github.io/grantpin-web/"

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
