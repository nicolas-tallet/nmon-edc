#!/bin/bash

# sensors -u | grep power[1-2]*[0-9]_input: | awk -v header="POWERUSAGE,$1" 'BEGIN {string=header} {string=string","$2} END {print string}'

sensors -u | awk 'BEGIN {record="POWERUSAGE,Power Usage"} match($0, /^\s*power[0-9]+_input: ([0-9\.]+)$/, a) {record=record","a[1]} END {print record}' >>"${NMON_OUTPUTFILE_NEDC}"
