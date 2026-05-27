#!/usr/bin/env python3
"""Downscale V-Slice/FlxAnimate spritemaps that exceed GPU MAX_TEXTURE_SIZE (4096)."""

import json
import os
import shutil
import subprocess
import sys

DEFAULT_MAX_SIZE = 4095


def get_png_size(png_path: str) -> tuple[int, int]:
    result = subprocess.run(
        ["sips", "-g", "pixelWidth", "-g", "pixelHeight", png_path],
        capture_output=True,
        text=True,
        check=True,
    )
    w = h = 0
    for line in result.stdout.splitlines():
        if "pixelWidth" in line:
            w = int(line.split()[-1])
        if "pixelHeight" in line:
            h = int(line.split()[-1])
    return w, h


def load_json(path: str):
    with open(path, "rb") as f:
        raw = f.read()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    return json.loads(raw.decode("utf-8"))


def save_json(path: str, data) -> None:
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, separators=(",", ":"))


def scale_sprites(data: dict, scale: float) -> None:
    for entry in data["ATLAS"]["SPRITES"]:
        s = entry["SPRITE"]
        for key in ("x", "y", "w", "h"):
            s[key] = int(round(s[key] * scale))
    if "meta" in data and "size" in data["meta"]:
        data["meta"]["size"]["w"] = int(round(data["meta"]["size"]["w"] * scale))
        data["meta"]["size"]["h"] = int(round(data["meta"]["size"]["h"] * scale))


def fix_atlas(folder: str, dry_run: bool = False, max_size: int = DEFAULT_MAX_SIZE) -> bool:
    png = os.path.join(folder, "spritemap1.png")
    json_path = os.path.join(folder, "spritemap1.json")
    if not os.path.isfile(png) or not os.path.isfile(json_path):
        return False

    w, h = get_png_size(png)
    if w <= max_size and h <= max_size:
        print(f"  skip (OK {w}x{h}): {folder}")
        return False

    scale = min(max_size / w, max_size / h)
    new_w = max(1, int(round(w * scale)))
    new_h = max(1, int(round(h * scale)))
    print(f"  fix {w}x{h} -> {new_w}x{new_h} (scale {scale:.4f}): {folder}")

    if dry_run:
        return True

    backup = folder + ".atlas_backup"
    if not os.path.isdir(backup):
        os.makedirs(backup, exist_ok=True)
        shutil.copy2(png, os.path.join(backup, "spritemap1.png"))
        shutil.copy2(json_path, os.path.join(backup, "spritemap1.json"))

    tmp_png = png + ".tmp.png"
    subprocess.run(
        ["sips", "-z", str(new_h), str(new_w), png, "--out", tmp_png],
        check=True,
    )
    os.replace(tmp_png, png)

    data = load_json(json_path)
    scale_sprites(data, scale)
    save_json(json_path, data)
    return True


def main():
    args = sys.argv[1:]
    dry_run = "--dry-run" in args
    max_size = DEFAULT_MAX_SIZE
    if "--max-size" in args:
        idx = args.index("--max-size")
        max_size = int(args[idx + 1])
        args = args[:idx] + args[idx + 2 :]
    args = [r for r in args if r != "--dry-run"]

    roots = args if args else [
        "psych-engine-foolsupdate/PsychEngine.app/Contents/Resources/mods/images/characters",
        "foolsupdate-patch/Contents/Resources/mods/images/characters",
    ]

    fixed = 0
    for root in roots:
        if not os.path.isdir(root):
            print(f"  skip missing: {root}")
            continue
        if os.path.isfile(os.path.join(root, "spritemap1.png")):
            print(f"\nFixing {root}...")
            if fix_atlas(root, dry_run, max_size):
                fixed += 1
            continue
        print(f"\nScanning {root}...")
        for dirpath, _, files in os.walk(root):
            if ".atlas_backup" in dirpath:
                continue
            if "spritemap1.png" in files and "spritemap1.json" in files:
                if fix_atlas(dirpath, dry_run, max_size):
                    fixed += 1

    print(f"\n{'Would fix' if dry_run else 'Fixed'} {fixed} atlas(es).")


if __name__ == "__main__":
    main()
