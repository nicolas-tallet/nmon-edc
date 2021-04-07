#!/bin/bash

outputfile_analysis="$(dirname "${NMON_OUTPUTFILE_NEDC}")/$(basename "${NMON_OUTPUTFILE_NEDC}" ".csv").log"

cat "${NMON_OUTPUTFILE_NEDC}" >>"${NMON_OUTPUTFILE_NMON}"

cat >"${outputfile_analysis}" << eof
$(awk -F ',' '{value=$13; if (min == "") {min = max = value}; if(value > max) {max = value}; if(value < min) {min = value}; total += value; count += 1} END {printf "-System:\n -Min.: [%i]\n -Avg.: [%i]\n -Max.: [%i]\n\n", min, total/count, max}' "${NMON_OUTPUTFILE_NEDC}")
$(awk -F ',' '{value=$7; if (min == "") {min = max = value}; if(value > max) {max = value}; if(value < min) {min = value}; total += value; count += 1} END {printf "-CPU0 (Socket #0):\n -Min.: [%i]\n -Avg.: [%i]\n -Max.: [%i]\n\n", min, total/count, max}' "${NMON_OUTPUTFILE_NEDC}")
$(awk -F ',' '{value=$10; if (min == "") {min = max = value}; if(value > max) {max = value}; if(value < min) {min = value}; total += value; count += 1} END {printf "-CPU1 (Socket #1):\n -Min.: [%i]\n -Avg.: [%i]\n -Max.: [%i]\n\n", min, total/count, max}' "${NMON_OUTPUTFILE_NEDC}")
$(awk -F ',' '{value=$3; if (min == "") {min = max = value}; if(value > max) {max = value}; if(value < min) {min = value}; total += value; count += 1} END {printf "-GPU[0,1,2] (Socket #0):\n -Min.: [%i]\n -Avg.: [%i]\n -Max.: [%i]\n\n", min, total/count, max}' "${NMON_OUTPUTFILE_NEDC}")
$(awk -F ',' '{value=$4; if (min == "") {min = max = value}; if(value > max) {max = value}; if(value < min) {min = value}; total += value; count += 1} END {printf "-GPU[3,4,5] (Socket #1):\n -Min.: [%i]\n -Avg.: [%i]\n -Max.: [%i]\n\n", min, total/count, max}' "${NMON_OUTPUTFILE_NEDC}")
eof
