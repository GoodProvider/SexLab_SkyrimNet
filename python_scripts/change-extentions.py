import os
from pathlib import Path

def main():
    # Target directory relative to where the command is run
    target_dir = Path("Scripts/Source")
    
    if not target_dir.exists() or not target_dir.is_dir():
        print(f"❌ Error: Target directory '{target_dir}' does not exist.")
        return

    # Snapshot the files first so we don't accidentally rename a file twice
    files = list(target_dir.iterdir())
    
    swapped_count = 0
    
    for file_path in files:
        if not file_path.is_file():
            continue
            
        # Swap .psc to .txt
        if file_path.suffix.lower() == '.psc':
            new_path = file_path.with_suffix('.txt')
            file_path.rename(new_path)
            print(f"🔄 Swapped: {file_path.name} -> {new_path.name}")
            swapped_count += 1
            
        # Swap .txt to .psc
        elif file_path.suffix.lower() == '.txt':
            new_path = file_path.with_suffix('.psc')
            file_path.rename(new_path)
            print(f"🔄 Swapped: {file_path.name} -> {new_path.name}")
            swapped_count += 1
                
    if swapped_count == 0:
        print("🤷 No .psc or .txt files found to swap.")
    else:
        print(f"✨ Successfully swapped {swapped_count} file(s)!")

if __name__ == "__main__":
    main()