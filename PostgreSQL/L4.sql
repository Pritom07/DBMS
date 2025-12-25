-- Under pb1 schema there are 2 tables : students, teachers

drop database if exists dcl;
create database dcl;
-- now select database dcl

-- creates two schema pb1 
create schema pb1;

-- create table under pb1 schema
create table if not exists pb1.students(
  id serial primary key,
  name varchar(50) not null,
  email varchar(60) unique not null,
  phone varchar(16)
);

create table if not exists pb1.teachers(
  id serial primary key,
  name varchar(50) not null,
  email varchar(50) unique not null,
  phone varchar(16) not null
);

--insert data into pb1.students table
insert into pb1.students(name,email,phone) values 
('John Smith', 'john.smith@example.com', '+1-555-123-4567'),
('Sarah Johnson', 'sarah.j@example.com', '+1-555-987-6543'),
('Michael Brown', 'michael.brown@example.com', NULL),
('Emily Davis', 'emily.davis@example.com', '+44-20-7946-0958'),
('David Wilson', 'david.wilson@example.com', '+61-2-9876-5432');

--insert data into pb1.teachers table
insert into pb1.teachers(name,email,phone)
values('Professor James Anderson', 'j.anderson@example.com', '+1-555-234-5678'),
('Dr. Maria Garcia', 'm.garcia@example.com', '+1-555-345-6789'),
('Mr. Robert Chen', 'r.chen@example.com', '+44-20-1234-5678'),
('Dr. Lisa Williams', 'l.williams@example.com', '+61-3-8765-4321'),
('Professor Kevin Taylor', 'k.taylor@example.com', '+1-555-456-7890');

--create user
create user pritom with login password '';

--grant database ,schema and table access
grant connect on database DCL to pritom;
grant usage on schema pb1 to pritom;
grant select,insert,update,delete on table pb1.students to pritom;
grant usage on sequence pb1.students_id_seq to pritom;

--now check from psql where Database[postgres] : dcl , Username[postgres] : pritom and password will be that
-- one which is used to create user pritom.
--you can also check from windows powershell by typing 'psql -U pritom -d dcl' and type password that you 
--used to create user pritom.but first check ...\PostgreSQL\18\bin in your path variable otherwise not worked.

--revoke connection privilige from pritom
revoke connect on database dcl from public;
--N.B :
-- suppose pritom, shaon and promit have access on dcl database. but i want to revoke database access to pritom. 
-- so i have to run 'revoke connect on database dcl from public;' this disconnect shaon and promit also from database dcl
-- that's why i again run 'grant connect on database DCL to shaon;' and also grant connect on database DCL to promit;


--revoke delete priviliges from pritom
revoke delete on table pb1.students from pritom;

--revoke update priviliges from pritom
revoke update on table pb1.students from pritom;

-- a new table 'employees' created in pb1 schema but it cann't be used by pritom until its priviliges are granted to pritom
create table if not exists pb1.employees(
  id serial primary key,
  name varchar(20)
);

insert into pb1.employees(name) values('Karim'),('Rahim');

--automatically get select privilige to pritom when new table created in pb1 schema;
alter default privileges in schema pb1
grant select on tables to pritom;

--now check pritom only can see(select) pb1.employees table

--to provide privilige only insert to pb1.employees table
grant usage on sequence pb1.employees_id_seq to pritom;
grant insert on table pb1.employees to pritom;

--revoke all priviliges of pb1.students table from pritom
revoke all privileges on table pb1.students from pritom;

--now revoke all privileges from all tables in pb1 schema to pritom
revoke all privileges on all tables in schema pb1 from pritom;

-- grant all privileges to pritom
grant all privileges on all tables in schema pb1 to pritom;

--after giving all priviliges on all tables in schema pb1, if you again want to control the priviliges 
--of pritom then simply run the revoke statements on specific tables that you previously run such as
-- delete and update revoke from pritom on pb1.students table.

--create view of teachers table
create view pb1.teachers_V as
select id,name,email from pb1.teachers;

-- access only the view of pb1.teachers table to read(select) to pritom
grant select on table pb1.teachers_V to pritom;
--N.B: simply you can run 'grant select on pb1.teachers_V to pritom'

--revoke privilige from pritom of pb1.teachers_V
revoke select on table pb1.teachers_V from pritom;
--N.B: since only select privilege was assigned you can simply run 
-- 'revoke all privileges on pb1.teachers_V from pritom'

--drop user
reassign owned by pritom to postgres;
drop owned by pritom;
drop user pritom;