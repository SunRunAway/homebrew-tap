#!/usr/bin/env python3
"""Pin the cask to the latest stable GitHub release and its asset digest."""
import json
from pathlib import Path
import re
import subprocess
import urllib.request
import xml.etree.ElementTree as ET

release = json.loads(subprocess.check_output([
    "gh", "api", "repos/SunRunAway/vertty/releases/latest",
], text=True))
tag = release["tag_name"]
if not re.fullmatch(r"v[0-9]+\.[0-9]+\.[0-9]+", tag):
    raise SystemExit(f"Unexpected stable release tag: {tag!r}")
asset, = [a for a in release["assets"] if a["name"] == "Vertty.zip"]
expected_url = f"https://github.com/SunRunAway/vertty/releases/download/{tag}/Vertty.zip"
if asset["browser_download_url"] != expected_url:
    raise SystemExit("Unexpected release asset URL")
digest = asset.get("digest") or ""
if not re.fullmatch(r"sha256:[0-9a-f]{64}", digest):
    raise SystemExit("Release asset has no valid SHA256 digest")
path = Path(__file__).resolve().parents[1] / "Casks/vertty.rb"
text = path.read_text()
for key, value in (("version", tag[1:]), ("sha256", digest.removeprefix("sha256:"))):
    text, count = re.subn(rf'^  {key} "[^"\n]+"$', f'  {key} "{value}"', text, flags=re.M)
    if count != 1:
        raise SystemExit(f"Expected exactly one {key} stanza")
# Only advertise self-updates once the published app has a real update entry.
# The initial empty appcast lets development builds check updates before that release.
feeds = [a for a in release["assets"] if a["name"] == "appcast.xml"]
auto_updates = False
if feeds:
    with urllib.request.urlopen(feeds[0]["browser_download_url"], timeout=30) as response:
        appcast = ET.fromstring(response.read())
    auto_updates = any(item.get("url") == expected_url for item in appcast.findall("./channel/item/enclosure"))
text = text.replace("  auto_updates true\n\n", "")
if auto_updates:
    text = text.replace('  app "Vertty.app"', '  auto_updates true\n\n  app "Vertty.app"')
path.write_text(text)
print(f"Vertty {tag}: {digest}")
