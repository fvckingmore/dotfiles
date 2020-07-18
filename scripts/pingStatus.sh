#!/bin/bash

COM=$(ping -c5 -i 0.3 1.1.1.1 | awk '/seq=/{print substr($7,6)}')
CONT=0
ACUM=0

for i in $COM; do

	[ $i -ne 0 ] && {

		((ACUM+=i));
		((CONT++));
	}
done

[ $ACUM -ne 0 ] && echo $((ACUM/CONT)) || echo "NE"



