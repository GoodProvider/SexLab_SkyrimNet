#!/usr/bin/env python3
"""
Rename .psc files to .txt in Scripts/Source/temp
Usage:
  python change.py            # dry-run by default
  python change.py --apply    # actually rename
  python change.py --path PATH --from .psc --to .txt --overwrite
"""
import argparse
from pathlib import Path

DEFAULT_PATH = Path("Scripts/Source/temp")

def find_files(path: Path, from_ext: str):
    if not path.exists():
        return []
    pattern = f"*{from_ext}" if from_ext.startswith('.') else f"*.{from_ext}"
    return sorted(path.glob(pattern))


def main():
    parser = argparse.ArgumentParser(description="Change file extensions in a folder")
    parser.add_argument("--path", "-p", type=Path, default=DEFAULT_PATH,
                        help="Folder containing files to change (default: Scripts/Source/temp)")
    parser.add_argument("--from", dest="from_ext", default=".psc",
                        help="Source extension (default: .psc)")
    parser.add_argument("--to", dest="to_ext", default=".txt",
                        help="Target extension (default: .txt)")
    parser.add_argument("--apply", action="store_true", help="Actually perform renames (default: dry-run)")
    parser.add_argument("--overwrite", action="store_true", help="Overwrite existing target files")
    args = parser.parse_args()

    path = args.path
    from_ext = args.from_ext if args.from_ext.startswith('.') else '.' + args.from_ext
    to_ext = args.to_ext if args.to_ext.startswith('.') else '.' + args.to_ext

    files = find_files(path, from_ext)
    if not files:
        print(f"No files with extension '{from_ext}' found in {path}")
        return

    print(f"Found {len(files)} file(s) to process in {path}")
    to_do = []
    for f in files:
        target = f.with_suffix(to_ext)
        action = {
            'src': str(f),
            'dst': str(target),
            'skip': False,
            'reason': ''
        }
        if target.exists() and not args.overwrite:
            action['skip'] = True
            action['reason'] = 'target exists (use --overwrite to replace)'
        to_do.append(action)

    for a in to_do:
        if a['skip']:
            print(f"SKIP: {a['src']} -> {a['dst']}  ({a['reason']})")
        else:
            if args.apply:
                src = Path(a['src'])
                dst = Path(a['dst'])
                try:
                    src.rename(dst)
                    print(f"RENAMED: {a['src']} -> {a['dst']}")
                except Exception as e:
                    print(f"ERROR: {a['src']} -> {a['dst']}: {e}")
            else:
                print(f"DRY-RUN: {a['src']} -> {a['dst']}")

    print("Done.")

if __name__ == '__main__':
    main()
