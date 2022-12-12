#!/usr/bin/env bash
st -e 'cd ~/.news/Feeds/
export PATH="$PATH":~/.local/opt/google-cloud-sdk/bin
git pull'
emacs --config news
st -e 'cd ~/.news/Feeds/
git add .
git commit -m "Updated: $(date)"
git push'
