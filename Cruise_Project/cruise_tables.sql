create table captain (cap_ID integer,
		      name text
		      primary key (cap_ID); 

create table cruise (c-num integer,
		     cost integer,
		     num_sold integer,
		     num_stops integer,
		     actual_arrive_date date,
		     actual_arrive_time time(0), 
		     actual_depart_date date,
		     actual_depart_time time(0), 
		     source text, 
		     destination text,
		     cap_ID integer,
		     primary key (c-num),
		     foreign key (cap_ID) references captain(cap_ID));

create table crew (crew_id integer,
		   name text);

create table schedule(day date,
		      depart_time time(0), 
		      arrive_time(0),
		      c-num integer,
		      foreign key (c-num) references cruise(c_num));

create table customer (ID integer, 
		       first_name text,
 		       last_name text, 
		       gender text, 
		       date_of_birth date, 
		       address text, 
		       contact_num integer,
		       ZIP_code integer);

create table ship (model text,
		   ship_ID integer,
		   make text,
		   age integer,
		   seats integer);

create table repairs (repair_date date,
		      repair_code integer,
		      ship_ID integer,
		      tech_ID integer,
		      primary key (repair_date, repair_code),
		      foreign key (ship_ID) references ship(ship_ID),
		      foreign key (tech_ID) references technician(tech_ID));

create table technician (tech_ID integer);

create table reservation ();


