-- Find the total number of parts supplied by each supplier. 
SELECT DISTINCT C.sid, COUNT(*)
FROM Catalog C
group by C.sid;

-- Find the total number of parts supplied by each supplier whsupplies at least 3 parts.
select distinct C.sid, count(*)
from Catalog C
group by C.sid
having COUNT(*) > 2;

-- For every supplier that supplies only green parts, print the name of the supplier and the total number of parts that he supplies.
select distinct S.sname, count(*)
from Suppliers S, Parts P, Catalog C
where S.sid = C.sid AND P.pid = C.pid AND P.color = 'Green'
group by S.sname, P.pid;

-- For every supplier that supplies green part and red part, print the
--name of the supplier and the price of the most expensive part that
--he supplies
select S.sname, MAX(C.cost)
from Suppliers S, Parts P, Catalog C
where S.sid = C.sid AND P.pid = C.pid 
group by S.sname, S.sid, P.color
having 	(P.color = 'green') AND (P.color = 'red')

