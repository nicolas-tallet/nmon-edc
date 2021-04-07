#!/bin/bash

#===============================================================================
# nmon External Data Collector
#===============================================================================
readonly NEDC_OUTFILE_PREFIX="nmon-edc-powerusage"
readonly NEDC_OUTFILE_EXTENSION="csv"
#export NMON_END="nedc::powerusage::nmon-end"
export NMON_END="${NEDC_LIBEXECDIR}/nedc/powerusage/nmon-end.sh"
export NMON_ONE_IN=1
#export NMON_SNAP="nedc::powerusage::nmon-snap"
export NMON_SNAP="${NEDC_LIBEXECDIR}/nedc/powerusage/nmon-snap.sh"
#export NMON_START="nedc::powerusage::nmon-start"
export NMON_START="${NEDC_LIBEXECDIR}/nedc/powerusage/nmon-start.sh"
export TIMESTAMP=0

#export NMON_PID_FILE=/tmp/${USER}.nmon.pid
#export POWERUSAGE_METRICS="System Power,GPU Power,Fan Power"
#export POWERUSAGE_POWER_MONITOR="/tmp/${USER}.power_monitor.txt"
