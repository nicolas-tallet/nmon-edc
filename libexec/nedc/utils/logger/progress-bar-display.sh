#!/bin/bash

#===============================================================================
# Function: Display Progress Bar
#===============================================================================
# Options:
#   -index-current INDEX : Current Index Value
#   -index-max MAX       : Maximum Index Value
#===============================================================================
nedc::utils::logger::progress-bar-display() {
	while (( $# > 0 )); do
		case "${1}" in
			-index-current)
				local index_current="${2}"
				shift
				;;
			-index-max)
				local index_max="${2}"
				shift
				;;
		esac
		shift
	done
	if [[ -z "${index_current}" ]]; then
		opcm::utils::logger::exception-raise -message "Missing Argument: [Current Index]"
	fi
	if [[ -z "${index_max}" ]]; then
		opcm::utils::logger::exception-raise -message "Missing Argument: [Max Index]"
	fi
	local progress=$(( index_current * 100 / index_max ))
	printf "%-*s" $(( progress + 1 )) '[' | tr ' ' '#'
	printf "%*s%3d%%\r"  $(( 100 - progress ))  "]" "${progress}"
	exit 0
}
