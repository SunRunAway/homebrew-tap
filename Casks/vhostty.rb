cask "vhostty" do
  version "0.4.0"
  sha256 "412b4e739ed1affa1fbbad0c7d4e620637e2933b0f95c9f7f3a0297f797eca1e"

  url "https://github.com/SunRunAway/vhostty/releases/download/v#{version}/Vhostty.zip"
  name "Vhostty"
  desc "Vertical-tab terminal for Claude Code and Codex"
  homepage "https://github.com/SunRunAway/vhostty"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Vhostty.app"

  # Releases are ad-hoc signed but not notarized, as with the curl installer.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Vhostty.app"]
  end
end
