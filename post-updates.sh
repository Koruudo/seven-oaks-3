#!/bin/bash

# 1. Run packwiz refresh
echo "Refreshing packwiz index..."
packwiz refresh

# 2. Stage all changes
echo "Staging changes..."
git add .

# 3. Prompt for commit message
echo -n "Enter commit message: "
read -r commit_msg

# Check if message is empty
if [ -z "$commit_msg" ]; then
    commit_msg="Update modpack: $(date +'%Y-%m-%d %H:%M')"
fi

# 4. Commit and Push
if git commit -m "$commit_msg"; then
    echo "Pushing to GitHub..."
    git push
else
    echo "Nothing to commit, skipping push."
fi

echo "Done!"
