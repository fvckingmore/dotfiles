#!/bin/bash

echo $@
echo $*
echo $#

while [ $# -ne 0 ]; do

	case $1 in 

		-a) echo a; shift ;;
		-b) echo b; shift ;;
		-c) echo c; shift ;;
		--) echo "--"; shift; break ;;
		*) echo "parametro $1 no conocido "; break ;;



	esac




done


echo "script end"
