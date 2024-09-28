Create table staff(
staff_id varchar(20),
staff_type varchar(30),
school_id varchar(20),
first_name varchar(100) not null,
last_name varchar(100) not null,
AGE INT,
DOB Date,
Gender varchar(10) check (gender in ('M', 'F')),
Join_date Date,
address_ID Varchar(20),
constraint pk_stf Primary key(staff_ID),
constraint fk_staff_schl foreign key(school_ID) References school(school_ID),
constraint fk_staff_addr foreign key(address_ID) References address(address_ID)
);

create table address(
address_id varchar(20),
Street varchar(100),
city varchar(50),
state varchar(30),
country varchar(30)
);

insert into address(address_id, street, city, state, country) values ('ADR10001','44940 Bluesteam circle', 'Baton Rouge', 'Louisiana', 'United states') ;


create table school (
school_id varchar(10),
school_name varchar(100),
education_board varchar(80),
constraint fk_school_addr foreign key(address_id) References address(address_id)
);