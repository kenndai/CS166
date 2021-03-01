-- Count how many parts in NYC have more than 70 parts on hand
select count(*)
from part_nyc nyc
where nyc.on_hand > 70;

-- Count how many total parts on hand, in both NYC and SFO, are Red
select sum(*)
from	(select sum(nyc.on_hand), sum(sfo.on_hand)
	from part_nyc nyc, part_sfo sfo
	where nyc.color = 0 and sfo.color = 0);

-- List all the suppliers that have more total on hand parts in NYC than they do in SFO
select nyc.supplier 
from part_nyc nyc
where nyc.supplier IN 	(select nyc2.supplier
			 from part_nyc nyc2, part_sfo sfo
			 where nyc2.on_hand > sfo.on_hand);

-- List all suppliers that supply parts in NYC that aren't supplied by anyone in SFO
select nyc2.supplier
from part_nyc nyc2 
where nyc2.part_num NOT IN	(select sfo.part_num
				 from part_sfo sfo);

-- Update all of the NYC on hand values to on hand - 10

-- Delete all parts from NYC which have less than 30 parts on hand
