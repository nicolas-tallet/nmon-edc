#!/usr/bin/env bash

awk_args='
match($0, /\|\s*Energy Consumed \(Joules\)\s*\|\s*([0-9]+)\s*\|/, a) {energy = a[1]}
match($0, /\|\s*Power Usage \(Watts\)\s*\|\s*Avg:\s*([0-9\.]+).*\|/, a) {power = a[1]}
END {printf "%s,%s,%i,%i", "DCGMISTATS", timestamp, energy, power}'

/usr/bin/dcgmi stats --job "${LSB_JOBID}" | /usr/bin/awk -v timestamp="${1}" "${awk_args}" >>"${NEDC_OUTFILE}"
