#!/usr/bin/env bash

#===============================================================================
# Environment: nmon Chart
#===============================================================================
readonly NMONCHART_PREFIX="/data_local/sw/nmon-edc/nmon-edc/opt/nmonchart/nmonchart/"
readonly NMONCHART_EXECBIN="${NMON_PREFIX}/bin/nmonchart"

nedc::apis::nmonchart::environment() { return 0; }
