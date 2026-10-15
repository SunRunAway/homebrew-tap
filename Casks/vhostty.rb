cask "vhostty" do
  version "0.5.1"
  sha256 "5a7312f9a03be726f9d2bbf3bef5585e455937b55998d5afe4868a69de199efc"

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
