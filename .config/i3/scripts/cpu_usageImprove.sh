#/bin/bash

LOAD=$(mpstat 1 1 | grep -i average | awk '{print $12}')


CPU=$((100,00 - $LOAD))

echo $CPU
echo $CPU

[[ $CPU -gt 70 ]] && exit 33

exit 0



