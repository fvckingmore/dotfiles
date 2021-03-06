#!/bin/bash -x

: '
---------------------------------
| Created by Adrian Moreno 2020 |
|								|
| Basic script for manage xflux |
| from CLI						|
---------------------------------
'


opt=$1



fKillProcess () {

	#local pids=$(ps -e | grep flux | awk '{ print $1 }')
	local pids=$(pidof xflux)
	for i in $pids; do

		sudo /bin/kill -s 9 $i

	done

}



fVerifyTime () {

	local time=$(date +%H%M)

	([ $time -ge 700 ] && [ $time -lt 1820 ]) && echo 0 || echo 1
}



fSetOpt () {

	case $opt in

		1) echo 4500 ;;

		2) echo 3100 ;;

		3) echo 2300 ;;

	esac

}


fSetTemp () {

	local time=$(fVerifyTime)
	local option=$1

	case $time in

		0) /usr/bin/xflux -l 35 -g 105 -k $option > /dev/null 2>&1 ;;

		1) /usr/bin/xflux -l 8 -g -60 -k $option > /dev/null  2>&1 ;;

	esac

}



fMain () {

	([ "$opt" = "-h" ] || [ "$opt" = "--help" ]) && {

		echo "Uso: $ ./filterManager [Option]";
		echo;
		echo "Options:";
		echo;
		echo "1. 4500";
		echo "2. 3400";
		echo "3. 2300";

	} || {

		fKillProcess;

		[ -z $opt ] && {

			opt=2;

			fSetTemp $(fSetOpt);

		} || fSetTemp $(fSetOpt $opt)
	}
}


fMain
