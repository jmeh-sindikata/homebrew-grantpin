cask "grantpin" do
  version "0.2.4"
  sha256 "31a0f168caf8c2d4960036211316f3a5f3c992f137d5aa6c40eca6b691a84f05"

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

  # No `launchctl:` here: Homebrew runs the uninstall stanza on every upgrade
  # too, which removed the background service each time. The app's
  # Settings > Uninstall (or `grantpin service uninstall`) removes it; zap
  # removes it as well.
  uninstall quit: "dev.grantpin.app"

  zap launchctl: "dev.grantpin.daemon",
      trash:     [
        "~/Library/Application Support/grantpin",
        "~/Library/LaunchAgents/dev.grantpin.daemon.plist",
        "~/Library/Logs/grantpin",
        "~/Library/Preferences/dev.grantpin.app.plist",
      ]

  caveats <<~EOS
    Open grantpin from Applications once to create the vault and install the
    background service.

    Upgrades keep the background service. Plain `brew uninstall` does not
    remove it: use Settings > Uninstall in the app first, or run
    `grantpin service uninstall`. `brew uninstall --zap` removes it too and
    deletes the vault with all your secrets.

    The Secure Enclave key in the Keychain is removed only by the app's own
    Settings > Uninstall.
  EOS
end
