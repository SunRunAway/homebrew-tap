# SunRunAway Homebrew tap

## Vertty

For Apple Silicon Macs running macOS 14 or later, with current Homebrew:

```bash
brew tap SunRunAway/tap
brew install --cask SunRunAway/tap/vertty
```

Update with `brew update && brew upgrade --cask vertty`.

Vertty is ad-hoc signed but not notarized by Apple. The cask automatically
removes `com.apple.quarantine` from Vertty after installation and upgrades,
matching the upstream curl installer. This bypasses the quarantine-triggered
Gatekeeper check for this app.

The cask pins the release version and SHA256. GitHub Actions checks the latest
stable [Vertty release](https://github.com/SunRunAway/vertty/releases) hourly
(scheduled runs may be delayed by GitHub). The Update Vertty workflow can also
be run manually. It uses this repository's `GITHUB_TOKEN`; no cross-repository
write token is needed.
