#!/bin/bash

#===============================================================================
# Environment: nmon
#===============================================================================
readonly NMON_PREFIX="/data_local/sw/nmon/16j"
readonly NMON_EXECBIN="${NMON_PREFIX}/bin/nmon"
readonly NMON_OPTIONS="-a -c 3600 -I 1.0 -M -s 1 -T -U"

nedc::apis::nmon::base() {
	return 0
}
