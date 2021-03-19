--count how many parts in NYC have more than 70 parts on hand
select count(*)
from part_nyc nyc
where nyc.on_hand > 70;

-- Count how many total parts on hand in NYC, are Red
--select red_parts
select sum(red_sums.sum)
from (	select sum(nyc.on_hand)
	from part_nyc nyc
	where nyc.color = 0) as red_sums;

-- Update all of the NYC on hand values to on hand - 10
update part_nyc
set on_hand = on_hand - 10;

-- Delete all parts from NYC which have less than 30 parts on hand
delete from part_nyc where 30 < on_hand;
