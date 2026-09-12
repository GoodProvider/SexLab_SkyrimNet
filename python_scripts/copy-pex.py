# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "rich",
# ]
# ///

import argparse
import shutil
from pathlib import Path
from rich.console import Console

# Initialize rich console for "expert-level" logging
console = Console()

def main():
    parser = argparse.ArgumentParser(description="Distribute compiled .pex files to their original directories.")
    parser.add_argument("--source", required=True, help="Directory containing the newly compiled .pex files")
    parser.add_argument("--destination", nargs="+", required=True, help="List of directories to check (order matters)")

    args = parser.parse_args()

    source_dir = Path(args.source)
    dest_dirs = [Path(d) for d in args.destination]

    if not source_dir.exists():
        console.print(f"[bold red]Error:[/bold red] Source directory '{source_dir}' does not exist.")
        return

    # Find all .pex files in the source
    pex_files = list(source_dir.glob("*.pex"))
    print ("  source:", source_dir)
    print ("  destinations:", dest_dirs)
    
    if not pex_files:
        console.print("[yellow]No .pex files found in source to distribute.[/yellow]")
        return

    console.print(f"[bold blue]Distribution:[/bold blue] Found {len(pex_files)} files in [cyan]{source_dir}[/cyan].")

    copied_count = 0
    dest_count = {} 
    for pex_path in pex_files:
        file_name = pex_path.name
        found = False

        for dest in dest_dirs:
            script_path = dest / "Source" / file_name.replace(".pex", ".psc")
            target_path = dest / file_name
            if script_path.exists():
                try:
                    shutil.copy2(pex_path, target_path)
                    console.print(f"  [green]✔[/green] {file_name} -> [dim]{dest}[/dim]")
                    found = True
                    copied_count += 1
                    dest_count[dest] = dest_count.get(dest, 0) + 1
                    break
                except Exception as e:
                    console.print(f"  [bold red]✘[/bold red] Failed to copy {file_name} to {dest}: {e}")
                    break
        
        if not found:
            console.print(f"  [bold yellow]![/bold yellow] Orphaned: [bold white]{file_name}[/bold white] (No match found in destinations)")

    console.print(f"\n[bold green]Success:[/bold green] Distributed {copied_count}/{len(pex_files)} files.")

    # Print distribution summary
    console.print(f"\n[bold blue]Distribution Summary:[/bold blue]")
    for dest in dest_dirs:
        count = dest_count.get(dest, 0) 
        console.print(f"  [dim]{dest}[/dim]: {count} files")

if __name__ == "__main__":
    main()