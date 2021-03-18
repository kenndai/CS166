#!/bin/bash
psql -h 127.0.0.1 mydb < create_tables.sql > /dev/null
sleep 5

psql -h 127.0.0.1 mydb < create_indexes.sql

printf "Query time for unclustered index"
cat <(echo '\timing') queries.sql |psql -h 127.0.0.1 mydb | grep Time | awk -F "Time" '{print $2;}'

psql -h 127.0.0.1 mydb < cluster.sql

printf "Query time for clustered index"
cat <(echo '\timing') queries.sql |psql -h 127.0.0.1 mydb | grep Time | awk -F "Time" '{print $2;}'

