#!/bin/bash

: '
---------------------------------
|	Backup Template for Servers	|
|	by Adrian Moreno			|
|	07/06/2020					|
--------------------------------

'


#########################
#VARIABLES
#########################

DATE=$(date +%a_%d-%m-%y)
BAK_FOLDER="/home/moreno/respaldo"
OPTS=$(getopt -o h -l etc,var,root,home,web,usr,tools -n "tmp" -- "$@")


#########################
#FILE LIST BY FOLDER
#########################

#Listas de archivos a respaldar
#dependendiendo de las carpetas y
#requisitos del servidor

ETC_FILES="
i3/
network/
"
VAR_FILES=""
ROOT_FILES=""
WEB_FILES=""
USR_FILES=""
TOOLS_FILES=""

HOME_FILES="
scripts/
pdfs/
statusTest.sh
"




#########################
#BACKUP FUNCTION
#########################

[ -d $BAK_FOLDER ] || mkdir $BAK_FOLDER

Backup() {

	BASE=$1
	FILES=$2
	mkdir $BAK_FOLDER/$(basename $BASE)

	for file in $FILES; do

		[ -d $BASE/$file ] && {

		mkdir -p $BAK_FOLDER/$(basename $BASE)/$file;
			cp -vfr $BASE/$file* $BAK_FOLDER/$(basename $BASE)/$file;

		} || {

		[ -f $BASE/$file ] && cp -vrf $BASE/$file	$BAK_FOLDER/$(basename $BASE) || {

				echo "$file no es un directorio o una carpeta";

			}

		}


	done
}


###########################
#ALTERNATIVES INSTRUCTIONS
###########################





#########################
#MAIN
#########################



eval set -- "$OPTS"

while true; do

	case "$1" in

		--etc ) Backup /etc "$ETC_FILES"; shift ;;

		--var ) Backup /var "$VAR_FILES"; shift;;

		--root ) Backup /root "$ROOT_FILES"; shift ;;

		--home ) Backup /home/moreno "$HOME_FILES"; shift ;;

		--web ) Backup /web "$WEB_FILES"; shift ;;

		--usr ) Backup /usr "$USR_FILES"; shift ;;

		--tools ) Backup /tools "$TOOLS_FILES"; shift ;;

		--) shift; break ;;

		*) break ;;
	esac
done


chown -R moreno:moreno $BAK_FOLDER
