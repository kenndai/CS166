-- Count how many parts in NYC have more than 70 parts on hand
select count(*)
from part_nyc nyc
where nyc.on_hand > 70;

-- Count how many total parts on hand, in both NYC and SFO, are Red
--select red_parts
--from	(select sum(nyc.on_hand), sum(sfo.on_hand)
--	from part_nyc nyc, part_sfo sfo
--	where nyc.color = 0 and sfo.color = 0) as red_parts;
select sum(red_sums.sum)
from (	select sum(nyc.on_hand)
	from part_nyc nyc
	where nyc.color = 0 
	UNION
	select sum(sfo.on_hand)
	from part_sfo sfo
	where sfo.color = 0) as red_sums;

-- List all the suppliers that have more total on hand parts in NYC than they do in SFO
select nyc_total.supplier
from (	select nyc.supplier, sum(nyc.on_hand)
	from part_nyc nyc
	group by nyc.supplier) as nyc_total,
     (	select sfo.supplier, sum(sfo.on_hand)
	from part_sfo sfo
	group by sfo.supplier) as sfo_total
where nyc_total.supplier = sfo_total.supplier and nyc_total.sum > sfo_total.sum;

-- List all suppliers that supply parts in NYC that aren't supplied by anyone in SFO
select distinct nyc.supplier
from part_nyc nyc
where nyc.part_number NOT IN (	select sfo.part_number
				from part_sfo sfo);

-- Update all of the NYC on hand values to on hand - 10
update part_nyc
set on_hand = on_hand - 10;

-- Delete all parts from NYC which have less than 30 parts on hand
delete from part_nyc where 30 < on_hand;
