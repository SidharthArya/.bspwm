#!/bin/sh

notify-send -u low "Memory Usage" "$(ps -eo pmem,comm | tail -n +2 | sort -n -r | head -n 10)"
