#!/bin/bash

[ -z $1 ] && SNAME=w1 || SNAME=$1
#screen -d -m -S $SNAME
screen -Sdm $SNAME

SRVR="
a
b
c
"

for N in {0..2}; do
	
	screen -S $SNAME -X screen $N
	screen -S $SNAME -p $N -X title gge;

done

screen -r $SNAME
