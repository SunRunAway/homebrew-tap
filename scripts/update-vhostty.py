#!/usr/bin/env python3
"""Pin the cask to the latest stable GitHub release and its asset digest."""
import json
from pathlib import Path
import re
import subprocess

release = json.loads(subprocess.check_output([
    "gh", "api", "repos/SunRunAway/vhostty/releases/latest",
], text=True))
tag = release["tag_name"]
if not re.fullmatch(r"v[0-9]+\.[0-9]+\.[0-9]+", tag):
    raise SystemExit(f"Unexpected stable release tag: {tag!r}")
asset, = [a for a in release["assets"] if a["name"] == "Vhostty.zip"]
expected_url = f"https://github.com/SunRunAway/vhostty/releases/download/{tag}/Vhostty.zip"
if asset["browser_download_url"] != expected_url:
    raise SystemExit("Unexpected release asset URL")
digest = asset.get("digest") or ""
if not re.fullmatch(r"sha256:[0-9a-f]{64}", digest):
    raise SystemExit("Release asset has no valid SHA256 digest")
path = Path(__file__).resolve().parents[1] / "Casks/vhostty.rb"
text = path.read_text()
for key, value in (("version", tag[1:]), ("sha256", digest.removeprefix("sha256:"))):
    text, count = re.subn(rf'^  {key} "[^"\n]+"$', f'  {key} "{value}"', text, flags=re.M)
    if count != 1:
        raise SystemExit(f"Expected exactly one {key} stanza")
path.write_text(text)
print(f"Vhostty {tag}: {digest}")
