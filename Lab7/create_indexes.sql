create index nyc_partnum_index
on part_nyc
[USING BTREE]
(part_number)

create index sfo_partnum_index
on part_sfo
[USING BTREE]
(part_number)
