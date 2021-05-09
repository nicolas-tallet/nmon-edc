# nmon External Data Collector (EDC)

## Purpose

Modular framework for nmon External Data Collector (EDC) feature

## Features

* Provides a modular architecture for leveraging nmon External Data Collectors
* Provides a Power Usage Data collector for IBM OpenPOWER systems

## Usage

### Execution

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

### Example

* Data Collection must be started in the following way:
```
$ ./nmon-edc -action start -data-collector powerusage -outputfile-nmon "./nmon.csv" -outputfile-nedc "./nmon-edc.csv"
[2021-02-12 16:48:17 +01:00] [WARN ] Removing Existing nmon Output File
removed './nmon.csv'
[2021-02-12 16:48:17 +01:00] [WARN ] Removing Existing nmon EDC Output File
removed './nmon-edc.csv'
[2021-02-12 16:48:17 +01:00] [INFO ] Started nmon Data Collection
```
Data Collection is performed in the background, with a 1-second sampling frequency.
Instant Power data are registered in the ouput file specified through the following option: `-outputfile-nedc`.

* Data Collection must be manually stopped in the following way:
```
$ ./nmon-edc -action stop -data-collector powerusage -outputfile-nmon "./nmon.csv" -outputfile-nedc "./nmon-edc.csv"
nmon killed (pid 134714)
[2021-02-12 16:51:16 +01:00] [INFO ] Stopped nmon Data Collection
```
In the above example, two data collection files are generated in the current working directory:
```
$ wc -l ./nmon*.csv
    162 /data_local/users/l0539783/nmon-edc.csv
  51341 /data_local/users/l0539783/nmon.csv
  51503 total
```

* The script automatically generates a basic analysis of the collected data. The outcome is placed in a file with a `.log` extension:
```
./nmon-edc.log
```
In the above example, the following statistics are produced:
```
$ cat ./nmon-edc.log
-System:
 -Min.: [475]
 -Avg.: [491]
 -Max.: [509]
-CPU0 (Socket #0):
 -Min.: [90]
 -Avg.: [100]
 -Max.: [112]
-CPU1 (Socket #1):
 -Min.: [82]
 -Avg.: [90]
 -Max.: [101]
-GPU[0,1,2] (Socket #0):
 -Min.: [113]
 -Avg.: [113]
 -Max.: [115]
-GPU[3,4,5] (Socket #1):
 -Min.: [112]
 -Avg.: [113]
 -Max.: [114]
```

## Reference

https://www.ibm.com/support/pages/nmon-and-external-data-collectors
