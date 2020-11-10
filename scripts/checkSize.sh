#!/bin/bash

BASE_FOLDER="/home/moreno/pruebaTiempo"
SERVERS="$(ls -1d $BASE_FOLDER/*)"



for SERVER in $SERVERS; do

	[[ -d $SERVER ]] && {

		NEW_FILE=$(echo $(ls -td1 $SERVER/*z2) | cut -d" " -f1 );
		OLD_FILE=$(echo $(ls -td1 $SERVER/*z2) | cut -d" " -f2 );

		NEW_SIZE=$(du $NEW_FILE | cut -f1);
		OLD_SIZE=$(du $OLD_FILE | cut -f1);

		DIFF=$(echo "scale=4; ($NEW_SIZE - $OLD_SIZE) / 1024" | bc );

		echo "La diferencia es de respaldo de $(basename $SERVER) es de ${DIFF}M";
		#DIFF=$((abs($DIFF)))

		#[[ $( echo "$NEW_SIZE == $OLD_SIZE" | bc ) -eq 1 ]] || {

		#}

		#[[ $(echo "$DIFF >") ]]
	}
done
