"""Package the project and import cache, excluding editor state and shader caches."""
from pathlib import Path
import zipfile

excluded = {".git", ".github", ".claude", ".codex", ".agents", ".vscode", ".idea", "__MACOSX"}
with zipfile.ZipFile("build.zip", "w", compression=zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
    for path in sorted(Path(".").rglob("*")):
        if not path.is_file() or path.is_symlink():
            continue
        if any(part in excluded for part in path.parts):
            continue
        if path.name in {"build.zip", "build.zip.sha256", "upload-result.json", ".DS_Store"}:
            continue
        if path.parts[:2] in {(".godot", "editor"), (".godot", "shader_cache"), (".godot", "mono")}:
            continue
        archive.write(path, path.as_posix())
