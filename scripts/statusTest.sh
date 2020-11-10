#!/bin/bash


CPU_USAGE() {

	echo $(mpstat 1 1 | awk '/Average/{print $NF}' | sed s/,/\./ | awk '{print 100-$0}')

}

RAM_USAGE() {

	echo $(free | awk '/Mem/{print $3/1000}')
}

clear
while [ 1 ]; do

	echo "CPU: $(CPU_USAGE)% | RAM: $(RAM_USAGE)M"

	printf "\033[A\033[A"

	sleep 1
done
