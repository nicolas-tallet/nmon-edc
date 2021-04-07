# nmon External Data Collector (EDC)

## Purpose

Modular 

## Features

* Provides a modular architecture for leveraging External Data Collectors
* Provides a Power Usage Data collector for IBM OpenPOWER systems

## Usage

```
nmon EDC (External Data Collector) 21.02.1

Usage: nmon-edc -action {start|stop} -data-collector COLLECTOR [-log-level LEVEL] [-outputfile-nedc FILE] [-outputfile-nmon FILE]

Options:
  -action ACTION               Start / Stop Data Collection = {start | stop}
  -data-collector COLLECTOR    Data Collector Name
  -log-level LEVEL             Log Level = {ALL | TRACE | DEBUG | INFO | WARN | ERROR | OFF}
  -outputfile-nedc FILE        Output File for nmon EDC Data
  -outputfile-nmon FILE        Output File for nmon Base Data

Available Data Collectors:
  powerusage     Power Usage Data Collection

```

## Reference

https://www.ibm.com/support/pages/nmon-and-external-data-collectors
