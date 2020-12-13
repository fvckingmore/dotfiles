#!/bin/bash

[ -z $1 ] && SNAME=w1 || SNAME=$1
#screen -d -m -S $SNAME
screen -Sdm $SNAME

SRVR="
a
b
c
"

for N in $SRVR; do
	
	screen -S w1 -X screen -t $N;

done
