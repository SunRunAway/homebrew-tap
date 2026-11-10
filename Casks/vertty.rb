cask "vertty" do
  version "0.9.1"
  sha256 "01f0a1472f184a226e0c3a622882bd3e7e13ec58b89ec3b211ae0835e7f40710"

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
