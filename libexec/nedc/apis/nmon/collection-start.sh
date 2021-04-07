#!/bin/bash

#===============================================================================
# Function: Collection Start
#===============================================================================
nedc::apis::nmon::collection-start() {
	nedc::utils::logger::event-log -level "${LOGGER_LEVEL_TRACE}" -message "Entering Module: [${FUNCNAME[0]}]"
	local return_code=0
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
		nedc::utils::logger::exception-raise -message "Missing Argument: [Filename]"
	fi
	if [[ -z "${directory}" ]]; then
		local directory="${PWD}"
		nedc::utils::logger::event-log -level "${LOGGER_LEVEL_WARN}" -message "Unspecified Argument: [Directory] - Defaulting to: [${directory}]"
	fi
	local command="${NMON_EXECBIN} -F ${filename} -m ${directory} ${NMON_OPTIONS}"
	nedc::utils::logger::event-log -level "${LOGGER_LEVEL_DEBUG}" -message "Command: [${command}]"
	${command}
	if (( ${?} == 0 )); then
		nedc::utils::logger::event-log -level "${LOGGER_LEVEL_DEBUG}" -message "Started Collection into File: [${directory}/${filename}]"
	else
		nedc::utils::logger::event-log -level "${LOGGER_LEVEL_ERROR}" -message "Failed Starting Collection"
		return_code=1
	fi
	nedc::utils::logger::event-log -level "${LOGGER_LEVEL_TRACE}" -message "Exiting Module: [${FUNCNAME[0]}]"
	return ${return_code}
}
