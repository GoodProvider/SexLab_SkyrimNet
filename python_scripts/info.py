import sys
import argparse
import re
import hashlib
# Create the parser
parser = argparse.ArgumentParser()

# Add arguments
parser.add_argument('-v', '--version', type=str, required=True)
parser.add_argument('-n', '--name', type=str, required=True)
parser.add_argument('-o', '--output', type=str, required=True)
args = parser.parse_args()

with open(args.output,"w") as fout:
    print("{",file=fout)
    print (f'   "name":"{args.name}",',file=fout)
    print (f'   "version":"{args.version}"',file=fout)
    print("}",file=fout)