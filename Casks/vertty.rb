cask "vertty" do
  version "0.7.1"
  sha256 "4bb81b4d1e47cf2220fb499ccbc31adf99f1fe83db5cc86f6456de117fad122f"

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
