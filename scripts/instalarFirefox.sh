#!/bin/bash

ruta=$1

if [ -n "$ruta" ]; then

    if [ -e $ruta/firefox* ]; then

        if [ -e /opt/firefox* ]; then

            echo "Eliminando archivos antiguos"
#            sudo rm -rf /opt/firefox*
#            sudo rm /usr/bin/firefox*

        fi

        echo "Intalando paquete..."

#       sudo mv $ruta/firefox* /opt/firefox
       sudo mv $ruta/firefox* /home/moreno/OPT/firefox

       echo "Creando enlace..."

#       sudo ln -s /opt/firefox/firefox /usr/bin/firefox
       sudo ln -s /home/moreno/OPT/firefox/firefox /home/moreno/BIN/firefox

    else

        echo "No existe el programa a instalar"

        exit 30

    fi

else

    echo "Debes agregar la ruta del directorio que contiene el paquete a instalar"

    echo "Ejemplo: ~$ instalarFirefox.sh /home/usuario/Descargas "

	echo "Ejemplo ~$ instalarFirefox.sh ."

fi
