DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Dept;
DROP TABLE IF EXISTS Graduate;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS work_dept;
DROP TABLE IF EXISTS Graduate;
DROP TABLE IF EXISTS Graduate;


CREATE TABLE Professor (SSN numeric(9, 0), name text,
						age INTEGER, rank text,
						specialty text,
						PRIMARY KEY(SSN));

CREATE TABLE Dept (dno INTEGER, dname text,
						office text, SSN numeric(9, 0), 
						PRIMARY KEY(dno),
						FOREIGN KEY(SSN) REFERENCES Professor(SSN), ON DELETE NO ACTION);
						
CREATE TABLE Graduate (SSN numeric(9, 0), name text,
						age INTEGER, deg_pg text,
						PRIMARY KEY(SSN),
						FOREIGN KEY(dno) REFERENCES Dept(dno), ON DELETE NO ACTION,
						FOREIGN KEY(SSN) REFERENCES Graduate(SSN), ON DELETE NO ACTION);

CREATE TABLE Project (pno INTEGER, sponsor text,
						start_date date, end_date date,
						budget INTEGER,
						PRIMARY KEY(pno));

CREATE TABLE work_dept (time_pc float,
						SSN numeric(9, 0), name text,	
						age INTEGER, rank text,
						specialty text,
						dno INTEGER, dname text, office text,
						PRIMARY KEY(SSN, dno),
						FOREIGN KEY (SSN) REFERENCES Professor(SSN), ON DELETE NO ACTION);

