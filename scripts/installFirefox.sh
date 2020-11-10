#!/bin/bash

DELETE () {

	echo "BORRANDO ARCHIVOS ANTIGUOS"
	echo ""

	sudo bin/rm -vrf /opt/firefox*

	sudo /bin/rm -vrf /usr/bin/firefox*

	sudo /bin/rm -vf /usr/bin/firefox*

	echo ""

}


COPY () {

	local route=$1


	echo "COPIANDO ARCHIVOS NUEVOS"
	echo ""

	sudo /bin/cp -vr $route/firefox /opt/

	echo ""

	sudo /bin/chmod -R ugo+xrw /opt/firefox*

	echo "CREANDO ENLACE"
	echo ""

	sudo /bin/ln -s /opt/firefox/firefox /usr/bin/firefox

}


ALERT() {

	echo "Uso:	# ./installFirefox.sh"
	echo "	# ./installFirefox.sh [ruta]"
	echo
	echo "Agregue la ruta del directorio donde se encuentra la carpeta firefox."
	echo "Si no agrega la ruta, se tomara como directorio el mismo donde se encuentra el script."
	echo
	echo "Ejemplo:	# ./installFirefox /home/usuario/Descargas/"
	echo "		# .installFirefox"

}

VERIFY () {

	local route=$1

	if [ -e $route/firefox ]; then

		echo 1

	else

		echo 0

	fi

}




if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$1" = "-help" ] || [ "$1" = "help" ]; then

	ALERT

elif [ -z $1 ]; then

	if [ $(VERIFY $(pwd)) -eq 1 ]; then

		folder=$(pwd)

	else

		echo "No exite la carpeta firefox en $(pwd)"
		echo

		ALERT

		exit 1

	fi

else

	if [ $(VERIFY $1) -eq 1 ]; then

		folder=$1

	else

		echo "No existe la carpeta firefox en $1"
		echo

		ALERT

		exit 1

	fi

fi


if (DELETE; COPY $folder); then

	echo "INSTALACION FINALIZADA CON EXITO"

else

	echo "HA FALLADO LA INSTALACION"

fi

