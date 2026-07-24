import argparse
import os
import re
import shutil
import xml.etree.ElementTree as ET

# State constants
NORMAL = 'NORMAL'

# Patterns
RE_FUNCTION = re.compile(r'^(\s*([^\s]+\s+)?Function\s+[^\s]+\(.*)$', re.IGNORECASE)
RE_PROPERTY_BLOCK = re.compile(r'^\s*([^\s^\[]+)(\[\])?\s+Property\s+[a-z0-9]+', re.IGNORECASE)
RE_AUTO = re.compile(r'\bAuto\b', re.IGNORECASE)
RE_SCRIPTNAME = re.compile(r'^\s*Scriptname\s+(\w+)', re.IGNORECASE)
RE_EXTENDS = re.compile(r'Extends\s+(\w+)', re.IGNORECASE)
RE_IMPORT = re.compile(r'^\s*Import\s+(\w+)', re.IGNORECASE)
RE_CLASS_USAGE = re.compile(r'\b([a-zA-Z_][a-zA-Z0-9_]*)\b')
# Captures 'TypeName' from 'TypeName varName ='
RE_ASSIGNMENT_DECLARATION = re.compile(r'^\s*([a-zA-Z0-9_]+)\s+[a-zA-Z0-9_]+\s+=\s+([^\s^\=]+)', re.MULTILINE | re.IGNORECASE)

def get_logical_lines(lines):
    """Joins lines ending with backslash '\' into single logical lines."""
    logical_lines = []
    buffer = ""
    for line in lines:
        stripped = line.rstrip('\r\n')
        # Check if line ends with backslash (ignoring trailing whitespace)
        if stripped.rstrip().endswith('\\'):
            # Remove the backslash and keep the rest in buffer
            buffer += stripped.rstrip()[:-1]
        else:
            buffer += stripped
            logical_lines.append(buffer)
            buffer = ""
    if buffer: # Catch any remaining content
        logical_lines.append(buffer)
    return logical_lines

def convert_to_native_header(line):
    line = line.strip()
    if not re.search(r'\bNative\b', line, re.IGNORECASE):
        return f"{line} Native\n"
    return f"{line}\n"

def convert_to_AutoReadonly(line):
    line = line.strip()
    if not re.search(r'\bAutoReadonly\b', line, re.IGNORECASE) and not re.search(r'\bAuto\b',line, re.IGNORECASE):
        return f"{line} AutoReadonly\n"
    return f"{line}\n"

def identify_used_classes(source_dir, class_filename, used_seen):
    print (f"{source_dir}: searching new classes")
    
    primitives = set({'string', 'int', 'float', 'bool', 'none'})

    RE_AS = re.compile(r'\b([a-zA-Z0-9_]+)\s+as\s+([a-zA-Z0-9_]+)', re.IGNORECASE)
    RE_GLOBAL_FUNCTION = re.compile(r'([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+)\(')
    used = set()
    for filename in os.listdir(source_dir):
        if filename.lower().endswith('.psc'):
            used_file = set() 
            with open(os.path.join(source_dir, filename), 'r', encoding='utf-8', errors='ignore') as f:
                # Use logical lines to ensure we don't miss assignments split by '\'
                lines = get_logical_lines(f.readlines())
                comment_block = False 
                for i,line in enumerate(lines):
                    if ";/" in line: 
                        comment_block = True
                    if "/;" in line:
                        comment_block = False 
                    stripped = re.sub(r'\;.*', '', line).strip()
                    if not stripped or comment_block:
                        continue

                    unseen_values = {} 
                    def class_add(name, t):
                        if name in used_seen or name in primitives:
                            return
                        if name not in class_filename:
                            unseen_values[name] = t
                        class_filename[name] = filename
                        used_file.add(name)
                        used.add(name)

                    if RE_SCRIPTNAME.search(stripped):
                        if RE_EXTENDS.search(stripped):
                            class_add(RE_EXTENDS.search(stripped).group(1).lower(), "extends")
                        else: 
                            continue 

                    for match in RE_ASSIGNMENT_DECLARATION.finditer(stripped):
                        class_add(match.group(1).lower(), f"assignment : {match.groups()}")

                    for match in RE_PROPERTY_BLOCK.finditer(stripped):
                        class_add(match.group(1).lower(), f"property : {match.groups()}")

                    for match in RE_AS.finditer(stripped):
                        class_add(match.group(2).lower(), f"as: {match.groups()}")
                    for match in RE_GLOBAL_FUNCTION.finditer(stripped):
                        class_name = match.group(1).lower()
                        if class_name in class_filename: 
                            class_add(match.group(1).lower(), f"global function: {match.groups()}")
                    # 6. Heuristic fallback (keep but improve)
                    #potential_classes = RE_CLASS_USAGE.finditer(stripped)
                    #for word in potential_classes:
                        #class_name = word.lower() 
                        #if class_name not in class_filename and class_name not in primitives:
                            #unseen_type[class_name] = f" class"

                    if len(unseen_values) > 0:
                        print ("----------------------------- ERROR: Unseen class usage -----------------------------")
                        print (f"{source_dir}\{filename}[{i+1}]\n  {line}\n  {stripped}")
                        for class_name, value  in unseen_values.items():
                            #print (f"   {class_name[filename.split('.')[0]]}")
                            print (f"     {class_name} ({value})")
                        exit() 
            if len(used_file) > 0:
                print (f"  {filename} new {len(used_file)}")
    return used

def strip_file(src_path):
    try:
        with open(src_path, 'r', encoding='utf-8', errors='ignore') as f:
            raw_lines = f.readlines()
    except Exception:
        return None

    # Merge multi-line continuations before processing
    logical_lines = get_logical_lines(raw_lines)
    out = []

    for line in logical_lines:
        # Strip comments
        stripped = re.sub(r'\;.*', '', line).strip()
        if not stripped:
            continue
        
        if RE_SCRIPTNAME.match(stripped):
            out.append(f"{stripped}\n")
        elif RE_PROPERTY_BLOCK.search(stripped):
            out.append(convert_to_AutoReadonly(stripped))
        elif RE_FUNCTION.match(stripped):
            out.append(convert_to_native_header(stripped))

    return ''.join(out)

def parse_ppj_imports(ppj_path):
    try:
        tree = ET.parse(ppj_path)
        root = tree.getroot()
        ns = {'ns': 'PapyrusProject.xsd'}
        
        vars_map = {}
        for var in root.findall('.//ns:Variable', ns) or root.findall('.//Variable'):
            name, val = var.get('Name'), var.get('Value')
            if name and val:
                vars_map[f"@{name}"] = val

        import_dirs = []
        project_dir = os.path.dirname(os.path.abspath(ppj_path))
        for imp in root.findall('.//ns:Import', ns) or root.findall('.//Import'):
            if imp.text:
                path = imp.text.strip()
                for var_key, var_val in vars_map.items():
                    path = path.replace(var_key, var_val)
                if not os.path.isabs(path):
                    path = os.path.normpath(os.path.join(project_dir, path))
                import_dirs.append(path)
        return list(set(import_dirs))
    except Exception as e:
        print(f"Error parsing PPJ: {e}")
        return []

def main():
    parser = argparse.ArgumentParser(description='Generate Native PSC headers for used classes.')
    parser.add_argument('-p', '--project', required=True, help='Path to skyrimse.ppj')
    parser.add_argument('-o', '--output', required=True, help='Output directory')
    parser.add_argument('-s', '--source', required=True, help='Source directory to scan for class usage')
    args = parser.parse_args()


    directories = [args.source] 
    class_filename = {} 
    sources = set() 
    import_directories = parse_ppj_imports(args.project)
    for directory in import_directories:
        if not os.path.exists(directory):
            print ("Warning: Import directory does not exist:", directory)
            continue
        if directory not in directories:
            directories.append(directory)

    for directory in directories:
        directory_total = 0
        for filename in os.listdir(directory):
            class_name = os.path.splitext(filename)[0].lower()
            class_filename[class_name] = os.path.join(directory, filename)
            if directory == args.source:
                sources.add(class_name)

    used_seen = set()
    if os.path.exists(args.output):
        shutil.rmtree(args.output)
    os.makedirs(args.output, exist_ok=True)
    next_source = args.source
    while True:
        used_new = identify_used_classes(next_source, class_filename, used_seen)
        print ('new classes:', len(used_new))

        if len(used_new) == 0:
            break 

        processed_files = set()
        total_count = 0

        for directory in directories:
            if not os.path.exists(directory):
                continue

            directory_total = 0
            for filename in os.listdir(directory):
                class_name = os.path.splitext(filename)[0].lower()
                if filename.lower().endswith('.psc') and class_name in used_new:
                    src_path = os.path.join(directory, filename)
                    out_path = os.path.join(args.output, filename)
                    content = strip_file(src_path)
                    if content:
                        with open(out_path, 'w', encoding='utf-8') as f:
                            f.write(content)
                        processed_files.add(class_name)
                        total_count += 1
                        directory_total += 1 
                  #      print(f"  Header generated: {filename}")
            if directory_total > 0:
                print (f"{directory}: {directory_total}")
        used_seen |= used_new
        next_source = args.output

    print(f"Wrote {len(used_seen)} required headers to {args.output}")

if __name__ == '__main__':
    main()