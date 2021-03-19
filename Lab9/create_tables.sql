drop table part_nyc;
create table part_nyc (part_number integer, 
                       supplier integer, 
                       color integer, 
                       on_hand integer, 
                       descr text);
--			Primary key(part_number)); 
COPY part_nyc
FROM '/extra/kdai002/cs166/Lab9/part_nyc.dat'
WITH DELIMITER ',';
