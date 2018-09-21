#!/bin/bash

#create a temp folder for save intermedia results

[ -d ../temp ] || mkdir ../temp

# reduce data size; only need to run once

cat ../data/flights.May2017-Apr2018.csv|sed '1d'|grep "GNV"|cut -f3,7,13,16,24 -d','|sed 's/"//g'|sort -t ',' -k 1 -k 3nbr -k 4nbr -k 5nbr|sed -E '1 i \
ORIGIN,DEST,DEP_DEL15,ARR_DEL15,WEATHER_DELAY\
' >../temp/GNV_flight_info.tmp

# then working on the new file "../temp/GNV_flight_info.tmp"

#setting count for flight from GNV to ATL
count=0

# Question 1
while read line; do
	ORIGIN=$(echo $line|cut -f1 -d',')
	DEST=$(echo $line|cut -f2 -d',')
	DEP_DEL15=$(echo $line|cut -f3 -d',') #define a variable that only include delayed more than 15 minutes out of Gainesville
	ARR_DEL15=$(echo $line|cut -f4 -d',') #define a variable that only include delayed more than 15 minutes into Gainesville
	WEATHER_DELAY=$(echo $line|cut -f5 -d',')

	if [[ $DEP_DEL15 = 1.00 || $ARR_DEL15 = 1.00 ]]; then #making "or" decision that satisfying all the scenario based on the question
		((count++))
		echo $count >>../temp/count.tmp #output the counting from the loop to a tmp file
	fi
done < "../temp/GNV_flight_info.tmp"

echo "The total number of flights that were delayed more than 15 minutes into or out of Gainesville is:"
tail -1 ../temp/count.tmp
exit
