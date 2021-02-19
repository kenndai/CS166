-- Find the pid of parts with cost lower than 10
SELECT C.pid
FROM Catalog C
WHERE C.cost < 10;

-- Name of parts with cost lower than 10
SELECT P.pname 
FROM Parts P, Catalog C
WHERE P.pid = C.pid AND	C.cost < 10;

-- Address of suppliers who supply "Fire Hydrant Cap"
SELECT S.address
FROM Suppliers S, Parts P, Catalog C
WHERE S.sid = C.sid AND P.pid = C.pid AND P.pname = 'Fire Hydrant Cap';

-- Name of suppliers who supply green parts
SELECT S.sname
FROM Suppliers S, Parts P, Catalog C
WHERE S.sid = C.sid AND P.pid = C.pid AND P.color = 'Green';

-- For each supplier, list supplier's name along with all parts' name that it supply
SELECT S.sname, P.pname
FROM Suppliers S, Parts P, Catalog C
WHERE S.sid = C.sid AND P.pid = C.pid;
