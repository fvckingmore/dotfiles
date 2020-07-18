#!/bin/bash

TEMP=$(acpi -t | cut -d" " -f 4)

echo "${TEMP}°C"
echo "${TEMP}°C"

([[ $(echo "$TEMP > 60" | bc) -eq 1 ]] && [[ $(echo "$TEMP <= 80" | bc) -eq 1 ]]) && echo "#B58900"


[[ $(echo "$TEMP > 80" | bc) -eq 1 ]] && exit 33

exit 0

