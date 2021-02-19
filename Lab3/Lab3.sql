DROP TABLE IF EXISTS Professor;
CREATE TABLE Professor (PROF_SSN numeric(9, 0) NOT NULL,
						name text,
						age INTEGER,
						rank text,
						specialty text,
						PRIMARY KEY(PROF_SSN));

DROP TABLE IF EXISTS Dept;
CREATE TABLE Dept  	   (dno INTEGER NOT NULL,
						dname text,
						office text,
						PRIMARY KEY(dno));

DROP TABLE IF EXISTS work_dept;
CREATE TABLE work_dept (time_pc float,
						PROF_SSN numeric(9, 0) NOT NULL,	
						dno INTEGER NOT NULL,
						PRIMARY KEY(PROF_SSN, dno),
						FOREIGN KEY (PROF_SSN) REFERENCES Professor(PROF_SSN),
						FOREIGN KEY (dno) REFERENCES Dept(dno));

DROP TABLE IF EXISTS runs;
CREATE TABLE runs 	   (dno INTEGER NOT NULL,
						PROF_SSN numeric(9, 0) NOT NULL,
						PRIMARY KEY (dno, PROF_SSN),
						FOREIGN KEY (PROF_SSN) REFERENCES Professor(PROF_SSN),
						FOREIGN KEY (dno) REFERENCES Dept(dno));

DROP TABLE IF EXISTS Graduate;
CREATE TABLE Graduate  (GRAD_SSN numeric(9, 0) NOT NULL, 
						dno INTEGER,
						name text,
						age INTEGER,
						deg_pg text,
						major text,
						PRIMARY KEY(GRAD_SSN),
						FOREIGN KEY(dno) REFERENCES Dept(dno));

DROP TABLE IF EXISTS Project;
CREATE TABLE Project   (pno INTEGER NOT NULL, 
						sponsor text,
						start_date date, 
						end_date date,
						budget float,
						PRIMARY KEY(pno));

DROP TABLE IF EXISTS Advisor;
CREATE TABLE Advisor   (SENIOR_SSN numeric(9, 0) NOT NULL,
						GRAD_SSN numeric(9, 0) NOT NULL,
						PRIMARY KEY (SENIOR_SSN, GRAD_SSN),
						FOREIGN KEY (SENIOR_SSN) REFERENCES Graduates(GRAD_SSN),
						FOREIGN KEY (GRAD_SSN) REFERENCES Graduates(GRAD_SSN));

DROP TABLE IF EXISTS Manages;
CREATE TABLE Manages   (pno INTEGER NOT NULL,
						PROF_SSN numeric(9, 0) NOT NULL,
						PRIMARY KEY (pno, PROF_SSN),
						FOREIGN KEY (PROF_SSN) REFERENCES Professor(PROF_SSN),
						FOREIGN KEY (pno) REFERENCES Projects(pno));

DROP TABLE IF EXISTS work_in;
CREATE TABLE work_in   (pno INTEGER NOT NULL,
						PROF_SSN numeric(9, 0) NOT NULL,
						PRIMARY KEY (pno, PROF_SSN),
						FOREIGN KEY (PROF_SSN) REFERENCES Professor(PROF_SSN),
						FOREIGN KEY (pno) REFERENCES Projects(pno));

DROP TABLE IF EXISTS supervises;
CREATE TABLE supervises(PROF_SSN numeric(9, 0) NOT NULL,
						GRAD_SSN numeric(9, 0) NOT NULL,
						pno INTEGER NOT NULL,
						PRIMARY KEY (PROF_SSN, pno, GRAD_SSN),
						FOREIGN KEY (PROF_SSN) REFERENCES Professor(PROF_SSN),
						FOREIGN KEY (pno) REFERENCES Projects(pno),
						FOREIGN KEY (GRAD_SSN) REFERENCES Graduates(GRAD_SSN)

--------------------------------------------

DROP TABLE IF EXISTS Musicians;
CREATE TABLE Muscicians 		(ssn numeric(9, 0) NOT NULL,
								name text,
								PRIMARY KEY (ssn));

DROP TABLE IF EXISTS Instruments;
CREATE TABLE Instruments		(instrID INTEGER NOT NULL,
								dname text,
								key CHAR(3),
								PRIMARY KEY (instrID));

DROP TABLE IF EXISTS Plays;
CREATE TABLE Plays				(ssn numeric(9, 0) NOT NULL,
								instrID INTEGER NOT NULL,
								PRIMARY KEY (ssn, instrID),
								FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
								FOREIGN KEY (instrID) REFERENCES Instruments(instrID));

DROP TABLE IF EXISTS Songs_Appears;
CREATE TABLE Songs_Appears		(songID INTEGER NOT NULL,
								author text,
								title text,
								albumIdentifier INTEGER NOT NULL,
								PRIMARY KEY (songID),
								FOREIGN KEY (albumIdentifier) REFERENCES Album_Producer); 

DROP TABLE IF EXISTS Telephone_Home;
CREATE TABLE Telephone_Home		(phone_no INTEGER NOT NULL,
								address	text,
								PRIMARY KEY (phone_no),
								FOREIGN KEY (address) References Place);

DROP TABLE IF EXISTS Lives;
CREATE TABLE Lives				(ssn numeric(9, 0) NOT NULL,
								phone_no INTEGER,
								address text,
								PRIMARY KEY (ssn, address),
								FOREIGN KEY (phone_no, address) REFERENCES Telephone_Home,
								FOREIGN KEY (ssn) REFERENCES Musicians);

DROP TABLE IF EXISTS Place;
CREATE TABLE Place				(address text);


DROP TABLE IF EXISTS Perform;
CREATE TABLE Perform			(songID INTEGER NOT NULL,
								ssn numeric(9, 0) NOT NULL,
								PRIMARY KEY (songID, ssn),
								FOREIGN KEY (songID) REFERENCES Songs_Appears,
								FOREIGN KEY (ssn) REFERENCES Musicians)

DROP TABLE IF EXISTS Album_Producer;
CREATE TABLE Album_Producer		(albumIdentifier INTEGER NOT NULL,
								ssn numeric(9, 0),
								copyrightDate date,
								title text,
								speed INTEGER,
								PRIMARY KEY (albumIdentifier),
								FOREIGN KEY (ssn) REFERENCES Musicians);
					 			



