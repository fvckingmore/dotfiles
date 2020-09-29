#!/bin/sh
# Example Bar Action Script for Linux.
# Requires: acpi, iostat.
# Tested on: Debian 10, Fedora 31.
#

datee() {

	DATE=$(date '+%a, %d %^b %H:%M');

	echo -n $DATE;

}

mem() {

	MEM=$(free | grep Mem | sed 's/  */ /g' | cut -d" " -f3 | xargs -I% echo "scale=2; % / 1024" | bc)
	TOT=$(free | grep Mem | sed 's/  */ /g' | cut -d" " -f2 | xargs -I% echo "scale=2; % / 1024" | bc)
	PERC=$(echo "scale=2; ($MEM*100)/$TOT" | bc)


	echo -n "${MEM}M (${PERC}%)"


}


cpuUsage() {

	LOAD=$(mpstat | grep -i all | sed -e 's/  */ /g' -e 's/,/\./g' | cut -d" " -f12 )

	CPU=$(echo "100.00 - $LOAD" | bc)

	echo -n "${CPU}%"


}

vol() {

	VOL=$(amixer -M get Master | grep -E -o "\[[0-9]+%\]" | xargs -n1 -I% echo -n "% " | sed 's/  */ /g' | cut -d" " -f1)

	echo -n $VOL

}


home() {

	HD=$(df /home | grep / | sed 's/  */ /g' | cut -d" " -f4 | xargs -I% echo "scale=2; % / 1024" | bc | xargs -I% echo "%M")

	echo -n $HD

}


iface() {

	if=$(ip route | grep default | cut -d" " -f5)
	ip=$(ip route show dev $if | grep kernel | sed 's/  */ /g' | cut -d" " -f7)

	echo -n "$ip"
}


gge() {

	COM=$(ping -c1 -i 0.3 8.8.8.8 | grep from | cut -d" " -f7 | sed -e 's/time=//g' -e 's/\..*//g')
	CONT=0
	ACUM=0

	#for i in $COM; do

	#	[ $i -ne 0 ] && {

	#		((ACUM+=i));
			#((CONT++));
	#	}
	#done


    #echo -n "$((ACUM/CONT))"
	echo -n $COM

}

fmore() {

	echo -n $(df /media/moreno/fvckingmore | grep / | sed 's/  */ /g' | cut -d" " -f4 | xargs -I% echo "scale=2; % / 1024" | bc | xargs -I% echo "%M")

}

temper() {

	TEMP=$(cat /sys/class/thermal/thermal_zone0/temp | xargs -I% echo "% / 1000" | bc)

	echo -n "${TEMP}°C"

}

TRAF() {


	echo -n $(~/.config/i3/scripts/bandwidthImprove | xargs -n1 -I% echo -n "% " | cut -d" " -f1-4)
}

obtain() {

    local sum=0
    local current=$(cat /sys/class/net/{w,e}*/statistics/${1}_bytes)


    for i in $current; do

        sum=$(echo "$sum + $i" | bc)
    done

    cache="/tmp/$1"

    [ -f $cache ] && old=$(cat $cache) || old=0
    echo $sum > $cache
    echo "$(( (sum-old) / 1024 ))"
}

nose() {

	down=$(obtain rx)
	up=$(obtain tx)

	echo -n "D ${down}K U ${up}K"

}



while :; do

	echo " +@fg=7; V $(vol)  +@fg=8;|  +@fg=3;M $(mem) +@fg=8; |  +@fg=6;/H $(home) /F $(fmore)  +@fg=8;|  +@fg=4;$(iface)  $(TRAF)  +@fg=5;$(gge)  +@fg=8;|  +@fg=2;C $(cpuUsage)  +@fg=8;|  T $(temper)  |  +@fg=1;$(datee)";



	#sleep 1;
done