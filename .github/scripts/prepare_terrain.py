"""Fetch the exact official Terrain3D native libraries paired with the editor add-on."""
from pathlib import Path
import hashlib
import stat
import subprocess
import tempfile
import zipfile

url = "https://github.com/TokisanGames/Terrain3D/releases/download/v1.0.2-stable/Terrain3D_v1.0.2-stable.zip"
expected = "a071850250ec5e596aa54da61c01d75768774eb379ee997584d426a45f4884a2"
with tempfile.TemporaryDirectory() as temporary:
    path = Path(temporary) / "terrain.zip"
    subprocess.run(["curl", "--fail", "--location", "--silent", "--show-error", url, "-o", str(path)], check=True)
    if hashlib.sha256(path.read_bytes()).hexdigest() != expected:
        raise SystemExit("Terrain3D release checksum mismatch")
    with zipfile.ZipFile(path) as archive:
        for item in archive.infolist():
            relative = Path(item.filename)
            if relative.is_absolute() or ".." in relative.parts or stat.S_ISLNK(item.external_attr >> 16):
                raise SystemExit("Unsafe Terrain3D archive entry")
            if relative.parts[:3] == ("addons", "terrain_3d", "bin"):
                archive.extract(item, ".")
