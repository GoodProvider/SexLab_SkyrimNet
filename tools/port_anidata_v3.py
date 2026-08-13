#!/usr/bin/env python3
"""Port SkyrimNet_SexLab animation JSON packs from display-name to registrar filenames (anidata 3.0).

Build name→registrar map from SLAnims JSON under --data-root (id + name), optionally
augment with --animdb SQLite. Rename unambiguous files; report ambiguous/unmatched.

Usage:
  python tools/port_anidata_v3.py --data-root c:/Skyrim/dev/mods --dry-run
  python tools/port_anidata_v3.py --data-root c:/Skyrim/dev/mods
"""

from __future__ import annotations

import argparse
import json
import re
import sqlite3
import sys
from collections import defaultdict
from pathlib import Path

STAGE_KEY_RE = re.compile(r"^stage[ _]?(\d+)$", re.IGNORECASE)


def lower_key_map(obj: dict) -> dict:
    out = {}
    for k, v in obj.items():
        lk = k.lower() if isinstance(k, str) else k
        if lk in out and lk != k:
            raise ValueError(f"case-conflicting keys in object: {k!r}")
        out[lk if isinstance(k, str) else k] = v
    return out


def normalize_speaking(value):
    """Accept nested arrays or flat CSV/strings; emit nested token arrays."""
    if not isinstance(value, list):
        return value
    out = []
    for el in value:
        if isinstance(el, list):
            out.append([str(t) for t in el])
        elif isinstance(el, str):
            parts = [p.strip() for p in el.split(",") if p.strip()]
            out.append(parts)
        elif el is None:
            out.append([])
        else:
            out.append([str(el)])
    return out


def normalize_file(data: dict) -> dict:
    """Light v3 normalize: top-level version, drop per-stage version, lowercase stage keys."""
    src = lower_key_map(data) if isinstance(data, dict) else {}
    out: dict = {}
    out["version"] = "3.0"
    if "creator" in src and isinstance(src["creator"], str):
        out["creator"] = src["creator"]
    for key in ("orgasm_expected", "clothed", "tags"):
        if key in src:
            out[key] = src[key]
    if "speaking_modifiers" in src:
        out["speaking_modifiers"] = normalize_speaking(src["speaking_modifiers"])
    if "transitions" in src and isinstance(src["transitions"], dict):
        tr = {}
        for k, v in src["transitions"].items():
            tr[str(k).lower() if isinstance(k, str) else k] = v
        out["transitions"] = tr

    stages = []
    for k, v in src.items():
        if not isinstance(k, str):
            continue
        m = STAGE_KEY_RE.match(k)
        if not m:
            continue
        stage_n = int(m.group(1))
        if isinstance(v, str):
            stages.append((stage_n, {"description": v}))
        elif isinstance(v, dict):
            st = lower_key_map(v)
            stage_obj = {}
            if "description" in st:
                stage_obj["description"] = st["description"]
            if "speaking_modifiers" in st:
                stage_obj["speaking_modifiers"] = normalize_speaking(st["speaking_modifiers"])
            if "clothed" in st:
                stage_obj["clothed"] = st["clothed"]
            if "tags" in st:
                stage_obj["tags"] = st["tags"]
            stages.append((stage_n, stage_obj))
    for stage_n, stage_obj in sorted(stages, key=lambda x: x[0]):
        out[f"stage {stage_n}"] = stage_obj
    return out


def collect_anims_from_obj(obj, out_pairs: list[tuple[str, str]], path: str):
    if isinstance(obj, dict):
        anim_id = obj.get("id")
        name = obj.get("name")
        if isinstance(anim_id, str) and anim_id and isinstance(name, str) and name:
            out_pairs.append((name, anim_id))
        for v in obj.values():
            collect_anims_from_obj(v, out_pairs, path)
    elif isinstance(obj, list):
        for el in obj:
            collect_anims_from_obj(el, out_pairs, path)


def load_slanims_map(data_root: Path) -> dict[str, set[str]]:
    """display name (exact) -> set of registrar ids (preserve registrar casing from first seen)."""
    name_to_regs: dict[str, set[str]] = defaultdict(set)
    name_case: dict[str, str] = {}
    reg_case: dict[str, str] = {}
    for p in data_root.rglob("*.json"):
        parts = [x.lower() for x in p.parts]
        if "slanims" not in parts:
            continue
        # prefer .../SLAnims/json/*.json
        try:
            if p.stat().st_size > 5_000_000:
                continue
            data = json.loads(p.read_text(encoding="utf-8", errors="ignore"))
        except Exception:
            continue
        pairs: list[tuple[str, str]] = []
        collect_anims_from_obj(data, pairs, str(p))
        for name, rid in pairs:
            nl = name.lower()
            rl = rid.lower()
            name_to_regs[nl].add(rl)
            name_case.setdefault(nl, name)
            reg_case.setdefault(rl, rid)
    # attach casing maps on function attributes for rename
    load_slanims_map.name_case = name_case  # type: ignore[attr-defined]
    load_slanims_map.reg_case = reg_case  # type: ignore[attr-defined]
    return name_to_regs


def load_animdb_map(db_path: Path) -> dict[str, set[str]]:
    name_to_regs: dict[str, set[str]] = defaultdict(set)
    if not db_path.is_file():
        return name_to_regs
    con = sqlite3.connect(str(db_path))
    try:
        cur = con.execute("SELECT registry, name FROM animations")
        for registry, name in cur.fetchall():
            if not registry or not name:
                continue
            name_to_regs[str(name).lower()].add(str(registry).lower())
            load_slanims_map.reg_case.setdefault(str(registry).lower(), str(registry))  # type: ignore
            load_slanims_map.name_case.setdefault(str(name).lower(), str(name))  # type: ignore
    finally:
        con.close()
    return name_to_regs


def merge_maps(a: dict[str, set[str]], b: dict[str, set[str]]) -> dict[str, set[str]]:
    out: dict[str, set[str]] = defaultdict(set)
    for src in (a, b):
        for k, v in src.items():
            out[k].update(v)
    return out


def stem_looks_like_registrar(stem: str, all_regs: set[str]) -> bool:
    return stem.lower() in all_regs


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "--data-root",
        type=Path,
        required=True,
        help="Root to scan for SLAnims/json (e.g. MO2 mods folder)",
    )
    ap.add_argument(
        "--animations-root",
        type=Path,
        default=None,
        help="Pack root (default: repo SKSE/Plugins/SkyrimNet_SexLab/animations)",
    )
    ap.add_argument("--animdb", type=Path, default=None, help="Optional animationdb.sql")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--normalize-only", action="store_true", help="Normalize content without rename")
    args = ap.parse_args()

    repo = Path(__file__).resolve().parents[1]
    anim_root = args.animations_root or (
        repo / "SKSE" / "Plugins" / "SkyrimNet_SexLab" / "animations"
    )
    if not anim_root.is_dir():
        print(f"animations root missing: {anim_root}", file=sys.stderr)
        return 2

    load_slanims_map.name_case = {}  # type: ignore
    load_slanims_map.reg_case = {}  # type: ignore
    name_map = load_slanims_map(args.data_root)
    if args.animdb:
        name_map = merge_maps(name_map, load_animdb_map(args.animdb))

    all_regs = set()
    for regs in name_map.values():
        all_regs.update(regs)

    renamed = 0
    normalized = 0
    ambiguous: list[str] = []
    unmatched: list[str] = []
    skipped_already = 0

    for path in sorted(anim_root.rglob("*.json")):
        if not path.is_file():
            continue
        stem = path.stem
        stem_l = stem.lower()

        # already registrar-named
        if stem_looks_like_registrar(stem, all_regs) and stem_l not in name_map:
            # still normalize content in place
            try:
                data = json.loads(path.read_text(encoding="utf-8"))
                new_data = normalize_file(data)
                if new_data != data and not args.dry_run:
                    path.write_text(json.dumps(new_data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
                    normalized += 1
                elif new_data != data:
                    normalized += 1
                skipped_already += 1
            except Exception as e:
                print(f"WARN normalize fail {path}: {e}")
            continue

        regs = name_map.get(stem_l, set())
        if len(regs) > 1:
            candidates = sorted(load_slanims_map.reg_case.get(r, r) for r in regs)  # type: ignore
            ambiguous.append(f"{path} | name={stem!r} | candidates={candidates}")
            continue
        if len(regs) == 0:
            unmatched.append(f"{path} | name={stem!r}")
            if args.normalize_only:
                try:
                    data = json.loads(path.read_text(encoding="utf-8"))
                    new_data = normalize_file(data)
                    if new_data != data:
                        if not args.dry_run:
                            path.write_text(
                                json.dumps(new_data, indent=2, ensure_ascii=False) + "\n",
                                encoding="utf-8",
                            )
                        normalized += 1
                except Exception as e:
                    print(f"WARN normalize fail {path}: {e}")
            continue

        rid_l = next(iter(regs))
        rid = load_slanims_map.reg_case.get(rid_l, rid_l)  # type: ignore
        dest = path.with_name(rid + ".json")

        try:
            data = json.loads(path.read_text(encoding="utf-8"))
            new_data = normalize_file(data)
        except Exception as e:
            print(f"WARN read/normalize fail {path}: {e}")
            continue

        if dest.resolve() == path.resolve():
            if new_data != data:
                if not args.dry_run:
                    path.write_text(json.dumps(new_data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
                normalized += 1
            skipped_already += 1
            continue

        if dest.exists() and dest.resolve() != path.resolve():
            ambiguous.append(f"{path} | name={stem!r} | dest exists {dest.name}")
            continue

        print(f"{'[dry-run] ' if args.dry_run else ''}RENAME {path.relative_to(anim_root)} -> {dest.name}")
        if not args.dry_run:
            path.write_text(json.dumps(new_data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
            path.rename(dest)
        renamed += 1
        normalized += 1

    print("---")
    print(f"name map entries: {len(name_map)}")
    print(f"renamed: {renamed}")
    print(f"normalized: {normalized}")
    print(f"already registrar / same stem: {skipped_already}")
    print(f"ambiguous: {len(ambiguous)}")
    print(f"unmatched: {len(unmatched)}")
    if ambiguous:
        print("\nAMBIGUOUS:")
        for line in ambiguous:
            print(" ", line)
    if unmatched:
        print("\nUNMATCHED:")
        for line in unmatched[:80]:
            print(" ", line)
        if len(unmatched) > 80:
            print(f"  ... and {len(unmatched) - 80} more")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
