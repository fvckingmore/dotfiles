#!/bin/bash

xset s off &
xset -dpms &
redshift -O 3500 &
nitrogen --restore &
xcompmgr -c -t-5 -l-5 -r5 -o.55 -fF -I.09 -O.09 -D2 &
bash ~/.dwm/bar.sh &

