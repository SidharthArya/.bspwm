#!/bin/sh
pgrep lock.sh && exit 1
gpgconf --kill gpg-agent
dm-tool lock
sleep 3
