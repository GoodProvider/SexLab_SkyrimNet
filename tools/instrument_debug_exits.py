"""Add DbgReturn before returns and DbgEnd before EndFunction for void functions."""
import re
from pathlib import Path

SOURCE = Path(r"c:\Skyrim\dev\mods\SkyrimNet_SexLab\Scripts\Source")

SKIP = {
    "Trace", "DbgEnter", "DbgReturn", "DbgEnd", "DbgSexLab",
    "GetString", "GetStyle", "GetTagsString",
}

FUNC_START = re.compile(
    r"^((?:Function|Event|int function|bool Function|String Function|"
    r"sslBaseAnimation\[\] Function|sslThreadController Function|"
    r"Actor Function|int Function|SkyrimNet_SexLab_Scene Function)\s+)(\w+)",
    re.I,
)

TYPED_START = re.compile(
    r"^(String|bool|int|sslBaseAnimation\[\]|sslThreadController|Actor|SkyrimNet_SexLab_Scene)\s+Function\s+(\w+)",
    re.I,
)


def process(content: str) -> str:
    lines = content.splitlines()
    out: list[str] = []
    func_name: str | None = None
    func_void = True

    for i, line in enumerate(lines):
        stripped = line.strip()

        tm = TYPED_START.match(line)
        if tm:
            func_name = tm.group(2)
            func_void = False
        else:
            fm = FUNC_START.match(line)
            if fm and fm.group(2) not in SKIP:
                func_name = fm.group(2)
                func_void = True

        if func_name and func_name not in SKIP and stripped.startswith("return"):
            indent = re.match(r"^(\s*)", line).group(1)
            prev = out[-1].strip() if out else ""
            if "DbgReturn(" not in prev:
                reason = stripped[6:].strip()
                if reason == "":
                    reason = "void"
                out.append(f'{indent}DbgReturn("{func_name}", "{reason}")')

        if stripped in ("EndFunction", "EndEvent") and func_name and func_name not in SKIP:
            indent = re.match(r"^(\s*)", line).group(1) or ""
            prev = out[-1].strip() if out else ""
            if func_void and "DbgEnd(" not in prev and "DbgReturn(" not in prev:
                out.append(f'{indent}DbgEnd("{func_name}")')
            func_name = None
            func_void = True

        out.append(line)

    return "\n".join(out)


def main():
    for fname in ("SkyrimNet_SexLab_Scene_Creator.psc", "SkyrimNet_SexLab_Scene.psc"):
        path = SOURCE / fname
        text = process(path.read_text(encoding="utf-8"))
        path.write_text(text, encoding="utf-8")
        print(f"{fname}: DbgReturn={text.count('DbgReturn(')} DbgEnd={text.count('DbgEnd(')}")


if __name__ == "__main__":
    main()
