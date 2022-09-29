#!/usr/bin/env bash

/usr/bin/sensors -u | /usr/bin/awk -v timestamp="${1}" 'match($0, /^\s+(\S+_input):\s+(\S+)$/, a) {printf "%s,%s,%s,%s\n", "SENSORS", timestamp, a[1], a[2]}' >>"${NEDC_OUTFILE}"
