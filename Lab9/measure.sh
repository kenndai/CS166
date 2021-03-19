#!/bin/bash
psql -h 127.0.0.1 kdai002_DB < create_tables.sql > /dev/null
sleep 5

psql -h 127.0.0.1 kdai002_DB < create_indexes.sql > /dev/null

printf "Query time for unclustered index\n"
cat <(echo '\timing') queries.sql |psql -h 127.0.0.1 kdai002_DB | grep Time | awk -F "Time" '{print $2;}'

psql -h 127.0.0.1 kdai002_DB < cluster.sql > /dev/null

printf "Query time for clustered index\n"
cat <(echo '\timing') queries.sql |psql -h 127.0.0.1 kdai002_DB | grep Time | awk -F "Time" '{print $2;}'

