#!/bin/bash

# sensors | grep W | cut -d : -f 1 | sed "s:[ ]*$::" | awk 'BEGIN {string="POWERUSAGE,Power Usage"} {string=string","$0} END {print string}'

sensors | awk 'BEGIN {record="POWERUSAGE,Power Usage"} match($0, /^(.*\S)\s*:\s*([0-9\.]+)\s*W\s*/, a) {record=record","a[1]} END {print record}' >"${NMON_OUTPUTFILE_NEDC}"
