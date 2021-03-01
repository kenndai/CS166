-- Count how many parts in NYC have more than 70 parts on hand
select count(*)
from part_nyc nyc
where nyc.on_hand > 70;

-- Count how many total parts on hand, in both NYC and SFO, are Red

-- List all the suppliers that have more total on hand parts in NYC than they do in SFO

-- List all suppliers that supply parts in NYC that aren't supplied by anyone in SFO

-- Update all of the NYC on hand values to on hand - 10

-- Delete all parts from NYC which have less than 30 parts on hand
