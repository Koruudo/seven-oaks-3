#!/bin/bash

# Change these to your actual GitHub info
USER="Koruudo"
REPO="seven-oaks-3"

for f in mods/*.pw.toml; do
    # Only target files that MISS an [update] section
    if ! grep -q "\[update\]" "$f"; then
        echo "Fixing orphan: $f"
        
        # Extract filename and encode it for the URL
        fname=$(grep "filename =" "$f" | cut -d'"' -f2)
        encoded_fname=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$fname'''))")
        
        url="https://raw.githubusercontent.com/$USER/$REPO/main/mods/$encoded_fname"
        
        # Check if url line already exists (to avoid double-injecting)
        if ! grep -q "url =" "$f"; then
            # Inject the URL line right under [download]
            sed -i "/\[download\]/a url = \"$url\"" "$f"
        fi
    fi
done

packwiz refresh
