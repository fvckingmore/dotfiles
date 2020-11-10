#!/bin/sh
#

date() {
	# The date is printed to the status bar by default.
	# To print the date through this script, set clock_enabled to 0
	# in spectrwm.conf.  Uncomment "print_date" below.
	FORMAT="%a %b %d %R %Z %Y"
	DATE=`date "+${FORMAT}"`
	echo -n "${DATE}     "
}

mem() {

MEM=$(free | grep Mem | sed 's/  */ /g' | cut -d" " -f3 | xargs -I% echo "scale=2; % / 1024" | bc)
TOT=$(free | grep Mem | sed 's/  */ /g' | cut -d" " -f2 | xargs -I% echo "scale=2; % / 1024" | bc)
PERC=$(echo "scale=2; ($MEM*100)/$TOT" | bc)

echo -n "${MEM}M (${PERC}%)"


}


cpu() {

	LOAD=$(mpstat 1 1 | grep -i average | sed -e 's/  */ /g' -e 's/,/\./g' | cut -d" " -f12)


	CPU=$(echo "100.00 - $LOAD" | bc)

	echo -n "${CPU}%"
}




while :; do

	echo "|  $(cpu)  |  $(mem)";


done
