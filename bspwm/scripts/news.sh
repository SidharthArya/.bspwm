#!/usr/bin/env bash
cd ~/.news/Feeds/
export PATH="$PATH":~/.local/opt/google-cloud-sdk/bin
git pull
emacs --config news
git add .
git commit -m "Updated: $(date)"
git push
