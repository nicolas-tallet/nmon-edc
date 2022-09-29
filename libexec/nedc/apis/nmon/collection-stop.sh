#!/usr/bin/env bash

#===============================================================================
# Function: Collection Stop
#===============================================================================
nedc::apis::nmon::collection-stop() {
	event-log -level "${LOGGER_LEVEL_TRACE}" -message "Entering Module: [${FUNCNAME[0]}]"
	local return_code=0
	pkill --echo --full --signal USR2 "${NMON_EXECBIN}"
	if (( ${?} == 0 )); then
		event-log -level "${LOGGER_LEVEL_DEBUG}" -message "Stopped nmon Data Collection"
	else
		event-log -level "${LOGGER_LEVEL_WARN}" -message "Failed to Stop nmon Data Collection - Making New Attempt with Kill Signal..."
		pkill --echo --full --signal SIGKILL "${NMON_EXECBIN}"
		if (( ${?} == 0 )); then
			event-log -level "${LOGGER_LEVEL_DEBUG}" -message "Stopped nmon Data Collection [with Kill Signal]"
		else
			event-log -level "${LOGGER_LEVEL_WARN}" -message "Failed to Stop nmon Data Collection"
			return_code=1
		fi
	fi
	event-log -level "${LOGGER_LEVEL_TRACE}" -message "Exiting Module: [${FUNCNAME[0]}]"
   return ${return_code}
}
