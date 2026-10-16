cask "vertty" do
  version "0.6.0"
  sha256 "8882a240c6c3df0d60da8ff07e2dcb7d98fea063207bd606f271fdc8dd70a2e8"

  url "https://github.com/SunRunAway/vertty/releases/download/v#{version}/Vertty.zip"
  name "Vertty"
  desc "Vertical-tab terminal for Claude Code and Codex"
  homepage "https://github.com/SunRunAway/vertty"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Vertty.app"

  # Releases are ad-hoc signed but not notarized, as with the curl installer.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Vertty.app"]
  end
end
