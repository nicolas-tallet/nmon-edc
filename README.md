# nmon External Data Collector (EDC)

## Purpose

Modular framework for nmon External Data Collector (EDC) feature 

## Features

- Provide a modular framework for developping and leveraging nmon External Data Collectors
- Provide an integrated External Data Collector based on the libsensors library

## Usage

### Options

```
nmon EDC (External Data Collector)

Usage: nmon-edc -action {start | stop} [-log-level LEVEL] -nedc NAME -outdir DIR [-outfile-nedc FILE] [-outfile-nmon FILE]

Options:
  -action ACTION        Start / Stop Data Collection: {start | stop}
  -log-level LEVEL      Log Level: {TRACE | DEBUG | INFO | WARN | ERROR}
  -nedc NAME            nmon External Data Collector Name
  -outdir DIR           Output Directory for nmon Base Data and nmon EDC Extended Data
  -outfile-nedc FILE    Output File for nmon EDC Extended Data
  -outfile-nmon FILE    Output File for nmon Base Data

Available Data Collectors:
  sensors    Data Collection through Sensors Library
```

> Note: Default output filename for nmon EDC extended data is built from the following format: `nedc.<Hostname>.<Timestamp>.<PID>.csv`

> Note: Default output filename for nmon base data is built from the following format: `nmon.<Hostname>.<Timestamp>.<PID>.csv`

### Example

- Startup:
```
/opt/nmon-edc/bin/nmon-edc -action "start" -log-level "DEBUG" -name "sensors" -outdir "/home/user1"
[2022-09-28 16:13:02 +02:00] [DEBUG] Performing Execution with Log Level: [DEBUG]
[2022-09-28 16:13:02 +02:00] [DEBUG] Command: [/usr/bin/nmon -F nmon.cn01.20220928T161302.2547231.csv -m /home/user1 -a -c 3600 -I 1.0 -M -s 1 -T -U]
[2022-09-28 16:13:02 +02:00] [DEBUG] Started Collection into File: [/home/user1/nmon.cn01.20220928T161302.2547231.csv]
[2022-09-28 16:13:02 +02:00] [INFO ] Started nmon Data Collection
```

- Termination:
```
/opt/nmon-edc/bin/nmon-edc -action "stop" -log-level "DEBUG" -name "sensors" -outdir "/home/user1"
[2022-09-28 16:13:32 +02:00] [DEBUG] Performing Execution with Log Level: [DEBUG]
nmon killed (pid 2547281)
[2022-09-28 16:13:32 +02:00] [DEBUG] Stopped nmon Data Collection
[2022-09-28 16:13:32 +02:00] [INFO ] Stopped nmon Data Collection
```

- Output Files:
  - `nmon.cn01.20220928T161302.2547231.csv`:
    - Base data collected through nmon
    - Default filename can be customized through the `-outfile-nmon` option
  - `nedc.cn01.20220928T161302.2547231.csv`:
    - Extended data collected through nmon External Data Collector
    - Default filename can be customized through the `-outfile-nedc` option
  - `nedc.cn01.20220928T161302.2547231.summary.csv`:
    - nmon External Data Collector summary (specific to sensors EDC)
    - Automatically generated statistics based on extended nmon EDC data
  - `nedc.cn01.20220928T161302.2547231.summary.err`:
    - nmon External Data Collector errors (specific to sensors EDC)

## Reference

- [nmon for Linux](https://nmon.sourceforge.net/)
- [nmon and External Data Collectors](https://www.ibm.com/support/pages/nmon-and-external-data-collectors)
