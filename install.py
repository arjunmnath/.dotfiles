import subprocess
import json

result = subprocess.run('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"', shell=True, capture_output=True, text=True)
print(result.stdout)
print(result.returncode)
