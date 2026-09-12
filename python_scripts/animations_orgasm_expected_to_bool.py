import json
from pathlib import Path

def convert_orgasm_expected():
    # Define the base directory path relative to where the script runs.
    # Adjust this path if you are running the script from a different location.
    base_dir = Path("SKSE/Plugins/SkyrimNet_SexLab/animations")
    
    if not base_dir.exists():
        print(f"Error: The directory '{base_dir}' does not exist.")
        print("Please place this script in the correct folder or update the 'base_dir' path.")
        return

    # Match all .json files in any subdirectory under animations/
    json_files = list(base_dir.glob("*/*.json"))
    
    if not json_files:
        print("No JSON files found in the target subdirectories.")
        return

    modified_count = 0

    for file_path in json_files:
        print (file_path)
        try:
            # 1. Read the JSON data
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            # 2. Check if the target key exists and is a list
            if "orgasm_expected" in data and isinstance(data["orgasm_expected"], list):
                # Convert 0 to False, 1 to True, and leave anything else as-is just in case
                original_array = data["orgasm_expected"]
                new_array = [True if val == 1 else False if val == 0 else val for val in original_array]
                
                # Only save if something actually changed to save processing time
                if original_array != new_array:
                    data["orgasm_expected"] = new_array
                    
                    # 3. Write the modified data back to the file
                    with open(file_path, 'w', encoding='utf-8') as f:
                        json.dump(data, f, indent=4)
                    
                    print(f"Successfully updated: {file_path.relative_to(base_dir.parent.parent.parent)}")
                    modified_count += 1
                    
        except json.JSONDecodeError:
            print(f"Skipping (Invalid JSON syntax): {file_path}")
        except Exception as e:
            print(f"Error processing {file_path}: {e}")

    print(f"\nTask complete. Updated {modified_count} file(s).")

if __name__ == "__main__":
    convert_orgasm_expected()