# SunRunAway Homebrew tap

## Vhostty

For Apple Silicon Macs running macOS 14 or later, with current Homebrew:

```bash
brew tap SunRunAway/tap
brew install --cask SunRunAway/tap/vhostty
```

Update with `brew update && brew upgrade --cask vhostty`.

Vhostty is ad-hoc signed but not notarized by Apple. The cask automatically
removes `com.apple.quarantine` from Vhostty after installation and upgrades,
matching the upstream curl installer. This bypasses the quarantine-triggered
Gatekeeper check for this app.

The cask pins the release version and SHA256. GitHub Actions checks the latest
stable [Vhostty release](https://github.com/SunRunAway/vhostty/releases) hourly
(scheduled runs may be delayed by GitHub). The Update Vhostty workflow can also
be run manually. It uses this repository's `GITHUB_TOKEN`; no cross-repository
write token is needed.
