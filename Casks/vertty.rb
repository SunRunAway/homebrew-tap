cask "vertty" do
  version "0.8.0"
  sha256 "f61a68d7974ceb963ffcad061c45ae2d04ba94335406b08664404d15cc9626db"

  url "https://github.com/SunRunAway/vertty/releases/download/v#{version}/Vertty.zip"
  name "Vertty"
  desc "Vertical-tab terminal for Claude Code and Codex"
  homepage "https://github.com/SunRunAway/vertty"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  auto_updates true

  app "Vertty.app"

  # Releases are ad-hoc signed but not notarized, as with the curl installer.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Vertty.app"]
  end
end
