#!/usr/bin/env python3
"""Add human labels to action YAMLs (line insert) and write webui/actions_index.json."""

from __future__ import annotations

import json
import re
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]
ACTIONS_DIR = ROOT / "SKSE" / "Plugins" / "SkyrimNet" / "config" / "actions"
OUT_JSON = ROOT / "SKSE" / "Plugins" / "SkyrimNet_SexLab" / "webui" / "actions_index.json"

LABELS: dict[str, str] = {
    "ShowComfort": "Comfort",
    "ExpressPhysicallyNonsexually": "Affection",
    "Sexlab_Punish": "Punish",
    "SexLab_Sexual_Activities_One": "Masturbation",
    "SexLab_Sexual_Activities_Two": "Sex",
    "SexLab_Sexual_Activities_Three": "Sex (three)",
    "SexLabComfortCuddle": "Cuddle",
    "SexLabComfortGeneral": "Comfort (general)",
    "SexLabComfortRefused": "Comfort refused",
    "SexLab_Nonsexual_Accepted": "Affection (accepted)",
    "SexLab_Nonsexual_Refused": "Affection refused",
    "SexLab_Start_Nonsexual_Three": "Affection (three)",
    "SexLab_Punish_Spanking_Target": "Spanking",
    "SexLab_Punish_Spanking_Speaker": "Spanking (by target)",
    "SexLab_Punish_Spanking_Victim_Nude_Target": "Spanking nude",
    "SexLab_Punish_Spanking_Victim_Nude_Speaker": "Spanking nude (by target)",
    "SexLab_Punish_Whipping_Oral_Target": "Whip",
    "SexLab_Punish_Whipping_Oral_Speaker": "Whip (by target)",
    "SexLab_Punish_Rape_Target": "Punish rape",
    "SexLab_Punish_Rape_Target_By_Target": "Punish rape (by target)",
    "SexLab_Punish_Refused": "Punish refused",
    "SexLab_Masturbation_Start": "Masturbate",
    "SexLab_Masturbation_Forced": "Forced masturbation",
    "SexLab_Sexual_Assault_Target": "Assault target",
    "SexLab_Sexual_Assault_Speaker": "Assault speaker",
    "SexLab_Sexual_Refused": "Sex refused",
    "SexLab_Start_Fucking": "Sex",
    "SexLab_Start_Fucking_Three": "Sex (three)",
    "SexLab_Start_Giving": "Giving",
    "SexLab_Start_Giving_Three": "Giving (three)",
    "change_outfit": "Change outfit",
    "change_outfit_target": "Change target outfit",
    "SexLab_Start_Rape": "Rape",
    "SEXLAB_STOP": "Stop",
}


def ensure_label(path: Path, name: str, label: str) -> str:
    """Insert or update label line after name:; return effective label."""
    text = path.read_text(encoding="utf-8")
    m = re.search(r"(?m)^label:\s*(.+)\s*$", text)
    if m:
        existing = m.group(1).strip().strip("\"'")
        return existing or label

    # Insert after the name: line
    name_re = re.compile(rf"(?m)^(name:\s*{re.escape(name)}\s*)$")
    if not name_re.search(text):
        name_re = re.compile(r"(?m)^(name:\s*.+)$")
    new_text, n = name_re.subn(rf"\1\nlabel: {label}", text, count=1)
    if n:
        path.write_text(new_text, encoding="utf-8")
        print(f"labeled: {path.name} -> {label}")
        return label
    print(f"warn: could not insert label in {path.name}")
    return label


def mapping_to_json(mapping: list | None) -> list[dict]:
    out: list[dict] = []
    if not mapping:
        return out
    for entry in mapping:
        if not isinstance(entry, dict):
            continue
        item = {
            "type": str(entry.get("type", "")).strip(),
            "name": str(entry.get("name", "")).strip(),
        }
        if "value" in entry and entry["value"] is not None:
            v = entry["value"]
            item["value"] = v if isinstance(v, (str, int, float, bool)) else str(v)
        if "description" in entry and entry["description"] is not None:
            item["description"] = str(entry["description"])
        out.append(item)
    return out


def main() -> None:
    actions: list[dict] = []
    by_category: dict[str, list[str]] = {}

    for path in sorted(ACTIONS_DIR.glob("*.yaml")):
        with path.open(encoding="utf-8") as f:
            data = yaml.safe_load(f) or {}
        if not isinstance(data, dict):
            continue
        name = data.get("name")
        if not name:
            print(f"skip (no name): {path.name}")
            continue

        wanted = LABELS.get(name)
        if wanted:
            label = ensure_label(path, name, wanted)
        else:
            label = data.get("label") or name

        # re-read after possible edit
        with path.open(encoding="utf-8") as f:
            data = yaml.safe_load(f) or {}
        label = data.get("label") or label

        entry = {
            "name": name,
            "label": label,
            "customCategory": data.get("customCategory") or "",
            "questEditorId": data.get("questEditorId") or "",
            "scriptName": data.get("scriptName") or "",
            "executionFunctionName": data.get("executionFunctionName") or "",
            "parameterMapping": mapping_to_json(data.get("parameterMapping")),
            "file": path.name,
        }
        actions.append(entry)

        cat = entry["customCategory"]
        if cat and entry["executionFunctionName"]:
            by_category.setdefault(cat, []).append(name)

    OUT_JSON.parent.mkdir(parents=True, exist_ok=True)
    OUT_JSON.write_text(
        json.dumps({"actions": actions, "by_category": by_category}, indent=2),
        encoding="utf-8",
    )
    print(f"wrote {OUT_JSON} ({len(actions)} actions)")


if __name__ == "__main__":
    main()
