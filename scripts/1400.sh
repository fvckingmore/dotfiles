#!/bin/bash
xrandr --newmode 1400x900  104.23  1400 1480 1632 1864  900 901 904 932  -HSync +Vsync
xrandr --addmode VGA1 1400x900
xrandr --output LVDS1 --mode 1024x600 --output VGA1 --mode 1400x900 --right-of LVDS1
