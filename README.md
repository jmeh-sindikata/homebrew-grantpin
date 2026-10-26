# homebrew-grantpin

Homebrew tap for [grantpin](https://github.com/jmeh-sindikata/grantpin), a local secrets broker for AI coding agents. It keeps your secrets in an encrypted vault on your Mac and hands them to an agent only when you approve the request (Touch ID or your password). grantpin is a notarized macOS menu-bar app plus a `grantpin` command-line tool. macOS 14 (Sonoma) or later.

More: [landing page](https://jmeh-sindikata.github.io/grantpin-web/) and the [main repository](https://github.com/jmeh-sindikata/grantpin).

## Install

```sh
brew install --cask jmeh-sindikata/grantpin/grantpin
```

Then open grantpin from Applications once. It creates the vault and installs the background service. The `grantpin` command is put on your PATH by the cask.

## Upgrade

```sh
brew upgrade --cask grantpin
```

## Uninstall

```sh
brew uninstall --cask grantpin
```

This removes the app and the `grantpin` command, and stops the background service. Your vault and logs are kept.

To also remove the vault and logs:

```sh
brew uninstall --zap --cask grantpin
```

**Warning:** `--zap` deletes the vault with all your secrets. This cannot be undone. The Secure Enclave key in your Keychain is removed only by the app's own Settings, Uninstall.
