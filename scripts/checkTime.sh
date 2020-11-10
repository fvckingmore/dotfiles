#!/bin/bash

: '
|---------------------------|
|	Script para chequeo de 	|
|	modificacion de carpetas|
|							|
|	by Adrian Moreno		|
|---------------------------|
'

BASE_DIR="/home/moreno/pruebaTiempo"
SERVERS="$(ls -u1d $BASE_DIR/*)"
ERROR=""


for SERVER in $SERVERS; do

	#SERVER="$BASE_DIR/$SERVER"
	DATE=$(date -r $SERVER)

	[[ -f $SERVER/date.log ]] && {

		OLD_DATE=$(< $SERVER/date.log)

		[[  "$DATE" == "$OLD_DATE" ]] && {

			ERROR="$ERROR $(basename $SERVER)"
		}
	}
	echo $DATE > $SERVER/date.log
done

#Comandos para alertar servidors sin respaldo
[[ -z $ERROR ]] || echo "Servidores sin resplado $ERROR"
