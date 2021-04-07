#!/bin/bash
#NMON=$(dirname $0)/nmon
source $(dirname $0)/powerusage.cfg
#ls $NMON_START $NMON_SNAP $NMON_END
function usage() {
  cat << EOF
  Usage: $0 ACTION [OPTIONS]
  works with nmon and powerusage

  where:
     ACTION=start [OPTIONS] : start nmon with OPTIONS
     ACTION=stop
     ACTION=chart : produces html chart(s) from nmon file 
EOF
}
function start() {
  export NMON_START NMON_SNAP NMON_END NMON_ONE_IN TIMESTAMP
  shift
  $NMON -p -f -a -s 1 -c 3600 $@ > ${NMON_PID_FILE} 2> ${NMON_PID_FILE}.err
}
function stop() {
  source $(dirname $0)/powerusage.cfg
  NMON_PID_FILE=${NMON_PID_FILE:-/dev/null}
  kill -s USR2 "$(cat ${NMON_PID_FILE})"
  rm -f ${NMON_PID_FILE}
}
function chart () {
  for NMON_FILE in $(ls *.nmon); do
  HTML_FILE=$(echo $NMON_FILE | sed 's:.nmon$:.html:')
  CMD="$(dirname $0)/nmonchart.powerusage ${NMON_FILE} ${HTML_FILE}"
  echo "Processing: $CMD"
  eval $CMD &
  done
  for PID in $(jobs -p); do
    wait $PID
  done
  echo  "Power Consumption of the nodes (Watts):"
#for file in *.html
#do
#	echo -n "$file      : "
#	awk 'BEGIN /title: "System Power Usage/ { print "Sys:"$8", GPU:"$12", Fan:"$16", DCMI:"$20 }' $file
#done
  echo -en "\t"
  grep "System Power Usage" *.html /dev/null | head -n 1 | sed 's:=: :g'| sed 's:,::g' | awk '{ print $6"\t"$8"\t"$10 }'
  grep "System Power Usage" *.html /dev/null | sed 's/_.*html//' | sed 's:=: :g'| sed 's:,::g' | awk '{ print $1"\t"$7"\t\t\t"$9"\t\t\t"$11}'
  #grep "System Power Usage" *.html /dev/null | sed 's:=: :g'| sed 's:,::g' | awk 'BEGIN {count=0; sum=0; max=0; sumg=0} { count+=1; if (max<$7) {max=$7}; sum+=$9; sumg+=$11} END {print $6"="max" "$8"="sum/count" "$10"="sumg/count}'
#  grep "System Power Usage" *.html /dev/null | sed 's:=: :g'| sed 's:,::g' | awk 'BEGIN {count=0; sum=0; max=0; sumg=0} { count+=1; if (max<$7) {max=$7}; sum+=$9; sumg+=$11} END {print "summary\t"max"\t\t\t"sum/count"\t\t\t"sumg/count}'
  grep "System Power Usage" *.html /dev/null | sed 's:=: :g'| sed 's:,::g' | awk 'BEGIN {count=0; sum=0; max=0; sumg=0} { count+=1; if (max<$7) {max=$7}; sum+=$9; sumg+=$11} END {printf "summary:\t%.2f\t%.2f\t%.2f\n",max,sum/count,sumg/count}'
  #awk 'BEGIN {sum1=0;num=0; sum2=0;sum3=0; sum4=0 } /title: "System Power Usage/ { sum1+=$8;num+=1; sum2+=$12; sum3+=$16; sum4+=$20 } END { print sum1/num"\t"sum2/num"\t"sum3/num"\t"sum4/num }' *.html
}
ACTION=$1
case $ACTION in
  start) start $@ ;;
  stop) stop;;
  chart) chart ;;
  *) usage ;;
esac
