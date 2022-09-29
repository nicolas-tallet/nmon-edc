#!/usr/bin/env bash

while read -r -u 9 feature; do
	label="NoLabel"
	label="$(cat "/sys/class/hwmon/hwmon0/${feature//_input/_label}")"
	label="${label%% }"
	awk -F ',' -v feature="${feature}" -v label="${label}" '
BEGIN {count = 0; max = 0; min = "NaN"; total = 0}
/'"${feature}"'/ {if (NR > 1) {count += 1; max = (NR == 2 || $4 > max ? $4 : max); min = (NR == 2 || $4 < min ? $4 : min); total += $4}}
END {if (count > 0) {avg = total / count; printf "%s,%s,%i,%i,%i\n", feature, label, min, avg, max}}
	' "${NEDC_OUTFILE}"
done 9< <(awk -F "," '{if (NR > 1) {print $3}}' "${NEDC_OUTFILE}" | sort --unique --version-sort) 1>"${NEDC_OUTFILE%.*}.summary.csv" 2>"${NEDC_OUTFILE%.*}.summary.err"
