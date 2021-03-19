create index nyc_partnum_index
on part_nyc
USING BTREE (part_number);
