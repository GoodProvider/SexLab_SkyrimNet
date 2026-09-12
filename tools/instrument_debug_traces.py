"""Add DbgEnter/DbgReturn/DbgEnd helpers and function entry traces."""
import re
from pathlib import Path

SOURCE = Path(r"c:\Skyrim\dev\mods\SkyrimNet_SexLab\Scripts\Source")

HELPERS = """
Function DbgEnter(String func)
    Trace(func, "--- enter")
EndFunction

Function DbgReturn(String func, String reason="")
    if reason != ""
        Trace(func, "--- return "+reason)
    else
        Trace(func, "--- return")
    endif
EndFunction

Function DbgEnd(String func)
    Trace(func, "--- end")
EndFunction

Function DbgSexLab(String func, String msg)
    Trace(func, "--- "+msg)
EndFunction

"""

SKIP_ENTER = {
    "Trace", "DbgEnter", "DbgReturn", "DbgEnd", "DbgSexLab",
    "GetString", "GetStyle",
}

FUNC_START = re.compile(
    r"^((?:Function|Event|int function|bool Function|String Function|"
    r"sslBaseAnimation\[\] Function|sslThreadController Function|"
    r"Actor Function|int Function|SkyrimNet_SexLab_Scene Function)\s+)(\w+)",
    re.I,
)


def add_helpers(content: str) -> str:
    if "Function DbgEnter" in content:
        return content
    marker = "EndFunction\n\nString Function GetString"
    if marker in content:
        return content.replace(
            "EndFunction\n\nString Function GetString",
            "EndFunction\n" + HELPERS + "\nString Function GetString",
            1,
        )
    raise ValueError("Could not insert helpers")


def add_function_entries(content: str) -> str:
    lines = content.splitlines()
    out: list[str] = []
    i = 0
    while i < len(lines):
        line = lines[i]
        m = FUNC_START.match(line)
        if not m or m.group(2) in SKIP_ENTER:
            out.append(line)
            i += 1
            continue

        func_name = m.group(2)
        # copy signature lines until closing paren line
        j = i
        while j < len(lines):
            out.append(lines[j])
            if lines[j].strip().endswith(")"):
                break
            j += 1
        i = j + 1

        # skip blank and comment lines, insert DbgEnter before first code
        while i < len(lines) and (
            lines[i].strip() == "" or lines[i].strip().startswith(";")
        ):
            out.append(lines[i])
            i += 1

        if i < len(lines) and f'DbgEnter("{func_name}")' not in lines[i]:
            indent = re.match(r"^(\s*)", lines[i]).group(1) or "    "
            out.append(f'{indent}DbgEnter("{func_name}")')

    return "\n".join(out)


def main():
    for fname in ("SkyrimNet_SexLab_Scene_Creator.psc", "SkyrimNet_SexLab_Scene.psc"):
        path = SOURCE / fname
        text = path.read_text(encoding="utf-8")
        text = add_helpers(text)
        text = add_function_entries(text)
        path.write_text(text, encoding="utf-8")
        count = text.count('DbgEnter("')
        print(f"{fname}: {count} DbgEnter calls")


if __name__ == "__main__":
    main()
