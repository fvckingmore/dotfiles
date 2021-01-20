#!/bin/bash

: '
Script bash for Custom menu on dmenu
for manage Screen Output

	by Adrian Moreno
	8/4/20
'


PROMPT="Screen Output"
OPTS="Laptop\nVGA Extended\nVGA Single\nManual"
#CHOISE=$(echo -e "$OPTS" | dmenu -i -p "$PROMPT" -nf '#FFFFFF' -nb '#002B36' -sb '#859900' -sf '#FFFFFF' -fn 'SFNS Display Bold-9' )
DIR="/home/moreno/.config/i3/scripts"
COM="[ "$(xrandr --query | awk '/VGA1/{print $2}')" = "disconnected" ]"

case $1 in

	#d) CHOISE=$(echo -e "$OPTS" | dmenu -i -p "$PROMPT" -nf '#FFFFFF' -nb '#282a36' -sb '#f1fa8c' -sf '#282a36' -fn 'Ubuntu Bold-10') ;;
	"d") CHOISE=$(echo -e "$OPTS" | dmenu -i -p "$PROMPT" -S -l 15); shift ;;

	"m") CHOISE=$2; shift; shift ;;

	$(echo $1 | grep -E "^$")) echo "necesita argumento"; exit 1 ;;

	*) echo "Opcion incorrecta" ;;
esac


case $CHOISE in

	Laptop) xrandr --output LVDS1 --primary --mode 1024x600 --output VGA1 --off; nitrogen --restore ;;

	"VGA Single") $COM || ($DIR/1280x720 && xrandr --output LVDS1 --off --output VGA1 --primary; ) ;;

	"VGA Extended") $COM || $DIR/1280x720; nitrogen --restore; xrandr --output LVDS1 --primary ;;

	"Manual") arandr ;;

esac
