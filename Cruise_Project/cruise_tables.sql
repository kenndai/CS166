create table captain (cap_ID integer not null,
		      name text
		      primary key (cap_ID); 

create table cruise (c-num integer not null,
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

create table crew (crew_id integer not null,
		   name text);

create table works (c-num integer not null,
		    crew_id integer not null,
		    primary key (c-num, crew_id)
		    foreign key (c-num) references cruise (c-num),
		    foreign key (crew_id) references crew (crew_id));

create table schedule(day date,
		      depart_time time(0) not null, 
		      arrive_time time(0) not null,
		      c-num integer not null,
		      primary key (c-num, depart_time, arrive_time),
		      foreign key (c-num) references cruise(c_num), on delete cascade);

create table customer (cust_ID integer not null, 
		       first_name text,
 		       last_name text, 
		       gender text, 
		       date_of_birth date, 
		       address text, 
		       contact_num integer,
		       ZIP_code integer,
		       primary key (cust_ID));

create table reservation (Rnum integer not null,
     			  primary key (Rnum));

create table waitlist (Rnum integer not null,
     		       primary key (Rnum),
		       foreign key references reservation(Rnum)); 

create table confirmed (Rnum integer not null,
     			primary key (Rnum),
			foreign key references reservation(Rnum)); 

create table reserved (Rnum integer not null,
     		       primary key (Rnum),
		       foreign key references reservation(Rnum)); 

create table has(cust_ID integer not null,
     		 c-num integer not null,
	         Rnum integer not null,
      		 primary key(cust_ID, c-num, Rnum),
      		 foreign key(cust_ID) references customer(cust_ID),
      		 foreign key(c-num) reference cruise(c-num),
      		 foreign key(Rnum) reference reservation(Rnum));

create table ship (ship_ID integer not null,
		   model text,
		   make text,
		   age integer,
		   seats integer,
		   primary key (ship_ID));

create table technician (tech_ID integer not null);

create table repairs (repair_date date not null,
		      repair_code integer not null,
		      ship_ID integer,
		      tech_ID integer,
		      primary key (repair_date, repair_code),
		      foreign key (ship_ID) references ship(ship_ID),
		      foreign key (tech_ID) references technician(tech_ID));

create table request (request_ID integer not null,
		      cap_ID integer not null,
		      ship_ID integer not null,
		      tech_ID integer not null,
		      primary key (request_ID, ship_ID, cap_ID, tech_ID,
		      foreign key (cap_ID) references captain(cap_ID),
		      foreign key (ship_ID) references ship(ship_ID),
		      foreign key (tech_ID) references technician(tech_ID));
