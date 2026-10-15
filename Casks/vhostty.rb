cask "vhostty" do
  version "0.5.0"
  sha256 "e082e6c1d8dd1132e4fff01467d9a2df13812aae3810f3d25b921dc69cb3c08e"

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
