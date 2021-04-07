#!/bin/bash
for NMON_FILE in $(ls *.nmon); do
	HTML_FILE=$(echo $NMON_FILE | sed 's:.nmon$:.html:')
	$(dirname $0)/nmonchart.powerusage ${NMON_FILE} ${HTML_FILE}
done
echo  "Power Consumption of the nodes (Watts):"
#for file in *.html
#do
#	
#	echo -n "$file      : "
#	awk 'BEGIN /title: "System Power Usage/ { print "Sys:"$8", GPU:"$12", Fan:"$16", DCMI:"$20 }' $file
#done
echo -en "\t\t\t\t"
grep "System Power Usage" *.html /dev/null | head -n 1 | awk '{ print $8"\t"$12"\t"$16"\t"$20 }'
grep "System Power Usage" *.html /dev/null | awk '{ print $1"\t"$9"\t"$13"\t"$17"\t"$21 }'
echo -ne "Average accorss nodes:\t\t"
awk 'BEGIN {sum1=0;num=0; sum2=0;sum3=0; sum4=0 } /title: "System Power Usage/ { sum1+=$8;num+=1; sum2+=$12; sum3+=$16; sum4+=$20 } END { print sum1/num"\t"sum2/num"\t"sum3/num"\t"sum4/num }' *.html
