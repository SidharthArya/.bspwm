#!/bin/sh

notify-send -u low "Cpu Usage" "$(ps -eo pcpu,comm | tail -n +2 | sort -n -r | head -n 10)"
