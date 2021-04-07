#!/bin/bash

#===============================================================================
# Environment
#===============================================================================
# Log Levels:
# 0=ALL < 1=TRACE < 2=DEBUG < 3=INFO < 4=WARN < 5=ERROR < 6=OFF
#===============================================================================
readonly LOGGER_LEVEL_ALL=0
readonly LOGGER_LEVEL_TRACE=1
readonly LOGGER_LEVEL_DEBUG=2
readonly LOGGER_LEVEL_INFO=3
readonly LOGGER_LEVEL_WARN=4
readonly LOGGER_LEVEL_ERROR=5
readonly LOGGER_LEVEL_OFF=6
readonly LOGGER_LEVELS=( "ALL" "TRACE" "DEBUG" "INFO" "WARN" "ERROR" "OFF" )
readonly LOGGER_FORMAT="[%26s] [%-5s] %s\n"

#===============================================================================
# Dummy Function
#===============================================================================
nedc::utils::logger::base() { return 0; }
