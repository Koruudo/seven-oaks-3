#!/bin/bash

# Your specific GitHub details
USER="Koruudo"
REPO="seven-oaks-3"
BRANCH="main"

for f in mods/*.pw.toml; do
    # Target only "Orphans" (No [update] section)
    if ! grep -q "\[update\]" "$f"; then
        
        # 1. Get the current filename from the TOML
        fname=$(grep "filename =" "$f" | cut -d'"' -f2)
        
        # 2. Encode it (Brackets and Spaces)
        encoded_fname=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$fname'''))")
        
        # 3. Construct the URL using YOUR verified format
        new_url="https://github.com/$USER/$REPO/raw/refs/heads/$BRANCH/mods/$encoded_fname"
        
        # 4. Wipe any existing url line and inject the fresh one under [download]
        sed -i '/url = /d' "$f"
        sed -i "/\[download\]/a url = \"$new_url\"" "$f"
        
        echo "Updated URL for: $fname"
    fi
done

# Sync the index
packwiz refresh
