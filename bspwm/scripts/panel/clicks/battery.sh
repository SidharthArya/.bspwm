#!/bin/sh
(echo Battery;upower -d) | dzen2 -e 'onstart=uncollapse' -p 1 -l 20
