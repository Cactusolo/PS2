#Within a function, prints a list of all unique airport codes contained in the dataset. (3 points)
##	 We observed only ""ORIGIN" and "DEST" columns containing the Airport code, so
cat ../data/flights.May2017-Apr2018.csv|sed '1d'|cut -f3,7 -d','|sed 's/"//g;s/,/\n/g'|sort|uniq >all_unique_airport_code.txt

#Within a function lists the cities in Florida that have airports in the dataset. (2 points)
##	the 4th column "ORIGIN_CITY_NAME"
cut -f4,5 -d',' ../data/flights.May2017-Apr2018.csv|grep "FL"|sed 's/"//g'|sort|uniq|cut -f1 -d',' >Airport_in_Florida_Cities.txt
