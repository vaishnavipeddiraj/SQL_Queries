select * from information_schema.tables where table_schema='[Public]';

Create table students(
ID varchar(20) Primary key,
First_name varchar(100) Not null,
last_name varchar(100) Not null,
Gender Varchar(10) check (gender in ('M', 'F', 'Male', 'Female')),
age INT,
DOB DATE,
CONSTRAINT CH_STUDENTS_AGE CHECK (AGE>0)

) 

INSERT INTO STUDENTS VALUES(101, 'Raj', 'Kumar', 'M', 25, Current_date);
INSERT INTO STUDENTS VALUES(102, 'Vaishnavi', 'peddiraj', 'F', 25, Current_date);
INSERT INTO STUDENTS VALUES(103, 'Ajay', 'Rama Raju', 'M', 25, Current_date);
INSERT INTO STUDENTS VALUES(104, 'Kinza', 'Tania', 'F', 29, Current_date);

select * from students;
