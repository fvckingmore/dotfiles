#!/bin/bash

check() {

	( [ $(cat /sys/class/net/w*/operstate) == "down" ] &&
	[ $(cat /sys/class/net/e*/operstate) == "down" ]) && {

		echo "NE";
		echo "NE";
		exit 33;

	}

}


obtain() {

	local sum=0
	local current=$(cat /sys/class/net/*/statistics/${1}_bytes)


	for i in $current; do

		sum=$(echo "$sum + $i" | bc)

	done

	cache="/tmp/$1"

	[ -f $cache ] && old=$(cat $cache) || old=0
	echo $sum > $cache
	echo "$(( (sum-old) / 1024 ))"
}

check

down=$(obtain rx)
up=$(obtain tx)



echo "D ${down}K U ${up}K"
echo "D ${down}K U ${up}K"







