cask "vertty" do
  version "0.9.0"
  sha256 "7b1e96e42fa03050d58807f9d58929065fddd9f26606bfe11ab255df2342b8d8"

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
