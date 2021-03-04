drop table if exists captain cascade;
create table captain (cap_ID integer not null,
		      name text,
		      primary key (cap_ID)); 

drop table if exists cruise cascade;
create table cruise (c_num integer not null,
		     cost integer,
		     num_sold integer,
		     num_stops integer,
		     actual_arrive_date date,
		     actual_arrive_time time(0), 
		     source text, 
		     destination text,
		     cap_ID integer,
		     primary key (c_num),
		     foreign key (cap_ID) references captain(cap_ID) on delete set default);

drop table if exists crew cascade;
create table crew (crew_id integer not null,
		   name text,
		   primary key (crew_id));

drop table if exists works;
create table works (c_num integer not null,
		    crew_id integer not null,
		    primary key (c_num, crew_id),
		    foreign key (c_num) references cruise (c_num),
		    foreign key (crew_id) references crew (crew_id));

drop table if exists schedule;
create table schedule(day date,
		      depart_time time(0) not null, 
		      arrive_time time(0) not null,
		      c_num integer not null,
		      primary key (c_num, depart_time, arrive_time),
		      foreign key (c_num) references cruise(c_num) on delete cascade);

drop table if exists customer cascade;
create table customer (cust_ID integer not null, 
		       first_name text,
 		       last_name text, 
		       gender text, 
		       date_of_birth date, 
		       address text, 
		       contact_num integer,
		       ZIP_code integer,
		       primary key (cust_ID));

drop table if exists reservation cascade;
create table reservation (r_num integer not null,
     			  primary key (r_num));

drop table if exists waitlist;
create table waitlist (r_num integer not null,
     		       primary key (r_num),
		       foreign key (r_num) references reservation(r_num) on delete cascade);

drop table if exists confirmed;
create table confirmed (r_num integer not null,
     			primary key (r_num),
			foreign key (r_num) references reservation(r_num) on delete cascade); 

drop table if exists reserved;
create table reserved (r_num integer not null,
     		       primary key (r_num),
		       foreign key (r_num) references reservation(r_num) on delete cascade); 

drop table if exists has;
create table has(cust_ID integer not null,
     		 c_num integer not null,
	         r_num integer not null,
      		 primary key(cust_ID, c_num, r_num),
      		 foreign key(cust_ID) references customer(cust_ID),
      		 foreign key(c_num) references cruise(c_num),
      		 foreign key(r_num) references reservation(r_num));

drop table if exists ship cascade;
create table ship (ship_ID integer not null,
		   model text,
		   make text,
		   age integer,
		   seats integer,
		   primary key (ship_ID));

drop table if exists technician cascade;
create table technician (tech_ID integer not null,
			 primary key(tech_ID));

drop table if exists repairs;
create table repairs (repair_date date not null,
		      repair_code integer not null,
		      ship_ID integer,
		      tech_ID integer,
		      primary key (repair_date, repair_code),
		      foreign key (ship_ID) references ship(ship_ID),
		      foreign key (tech_ID) references technician(tech_ID));

drop table if exists request;
create table request (request_ID integer not null,
		      cap_ID integer not null,
		      ship_ID integer not null,
		      tech_ID integer not null,
		      primary key (request_ID, ship_ID, cap_ID, tech_ID),
		      foreign key (cap_ID) references captain(cap_ID) on delete cascade,
		      foreign key (ship_ID) references ship(ship_ID),
		      foreign key (tech_ID) references technician(tech_ID));
