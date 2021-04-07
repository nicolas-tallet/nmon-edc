#!/bin/bash

#===============================================================================
# Function: Log Event
#===============================================================================
# Options:
#   -level LEVEL     : Event Level
#   -message MESSAGE : Event Message
#===============================================================================
nedc::utils::logger::event-log() {
	while (( $# > 0 )); do
		case "${1}" in
			-level)
				local -i level="${2}"
				shift
				;;
			-message)
				local message="${2}"
				shift
				;;
		esac
		shift
	done
	if (( level == LOGGER_LEVEL_ALL )) || (( level >= LOG_LEVEL )); then
		printf "${LOGGER_FORMAT}" "$(date "+%Y-%m-%d %H:%M:%S %:z")" "${LOGGER_LEVELS[${level}]}" "${message}"
	fi
	return 0
}
