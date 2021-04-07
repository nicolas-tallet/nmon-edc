#!/bin/bash

#===============================================================================
# Function: Raise Exception
#===============================================================================
# Options:
#   -message MESSAGE : Error Message
#===============================================================================
nedc::utils::logger::exception-raise() {
	while (( $# > 0 )); do
		case "${1}" in
			-message)
				local message="${2}"
				shift
				;;
		esac
		shift
	done
	printf "${LOGGER_FORMAT}" "$(date "+%Y-%m-%d %H:%M:%S %:z")" "${LOGGER_LEVELS[${LOGGER_LEVEL_ERROR}]}" "${message:-Undefined Exception} @ ${FUNCNAME[1]}:${BASH_LINENO[0]}"
	exit 9
}
