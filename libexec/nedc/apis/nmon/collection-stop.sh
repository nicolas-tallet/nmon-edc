#!/bin/bash

#===============================================================================
# Function: Collection Stop
#===============================================================================
nedc::apis::nmon::collection-stop() {
	nedc::utils::logger::event-log -level "${LOGGER_LEVEL_TRACE}" -message "Entering Module: [${FUNCNAME[0]}]"
	local return_code=0
	pkill --echo --full --signal USR2 "${NMON_EXECBIN}"
	if (( ${?} == 0 )); then
		nedc::utils::logger::event-log -level "${LOGGER_LEVEL_DEBUG}" -message "Stopped nmon Data Collection"
	else
		nedc::utils::logger::event-log -level "${LOGGER_LEVEL_WARN}" -message "Failed Stopping nmon Data Collection - Making Attempt with Kill Signal..."
		pkill --echo --full --signal SIGKILL "${NMON_EXECBIN}"
		if (( ${?} == 0 )); then
			nedc::utils::logger::event-log -level "${LOGGER_LEVEL_DEBUG}" -message "Stopped nmon Data Collection [with Kill Signal]"
		else
			nedc::utils::logger::event-log -level "${LOGGER_LEVEL_ERROR}" -message "Failed Stopping nmon Data Collection"
			return_code=1
		fi
	fi
	nedc::utils::logger::event-log -level "${LOGGER_LEVEL_TRACE}" -message "Exiting Module: [${FUNCNAME[0]}]"
   return ${return_code}
}
