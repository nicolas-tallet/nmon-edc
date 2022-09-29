#!/usr/bin/env bash

#===============================================================================
# Function: Collection Start
#===============================================================================
nedc::apis::nmon::collection-start() {
	event-log -level "${LOGGER_LEVEL_TRACE}" -message "Entering Module: [${FUNCNAME[0]}]"
	while (( $# > 0 )); do
		case "${1}" in
			-filename)
				local filename="${2}"
				shift
				;;
			-directory)
				local directory="${2}"
				shift
				;;
		esac
		shift
	done
	if [[ -z "${filename}" ]]; then
		event-log -level "${LOGGER_LEVEL_ERROR}" -message "Missing Argument: [Filename]"
	fi
	if [[ -z "${directory}" ]]; then
		local directory="${PWD}"
		event-log -level "${LOGGER_LEVEL_WARN}" -message "Unspecified Argument: [Directory] - Defaulting to: [${directory}]"
	fi
	local command="${NMON_EXECBIN} -F ${filename} -m ${directory} ${NMON_OPTIONS}"
	event-log -level "${LOGGER_LEVEL_DEBUG}" -message "Command: [${command}]"
	${command}
	if (( $? == 0 )); then
		event-log -level "${LOGGER_LEVEL_DEBUG}" -message "Started Collection into File: [${directory}/${filename}]"
	else
		event-log -level "${LOGGER_LEVEL_WARN}" -message "Failed to Start Collection"
	fi
	event-log -level "${LOGGER_LEVEL_TRACE}" -message "Exiting Module: [${FUNCNAME[0]}]"
	return 0
}
