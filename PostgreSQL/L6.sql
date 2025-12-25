-- 2 tables : students and debug_log inside function createDebug_log

drop database if exists funcproc;
create database funcproc;
-- now select database funcproc

--create table students and insert data
create table if not exists students (
  student_id int primary key,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  email varchar(100) not null,
  phone varchar(20),
  country varchar(50),
  enrollment_date date
);

insert into
  students (
    student_id,
    first_name,
    last_name,
    email,
    phone,
    country,
    enrollment_date
  )
values
  (
    1,
    'Rahim',
    'Uddin',
    'rahim@email.com',
    '01711111111',
    'Bangladesh',
    '2023-01-10'
  ),
  (
    2,
    'Karim',
    'Ahmed',
    'karim@email.com',
    NULL,
    'Bangladesh',
    '2023-01-15'
  ),
  (
    3,
    'Sara',
    'Khan',
    'sara@email.com',
    '01822222222',
    'Pakistan',
    '2023-02-01'
  );

-- create table debug_log inside function createDebug_log
create function createDebug_log()
returns void
language plpgsql
as 
$$
 begin
 create table if not exists debug_log(
  msg text,
  created_at timestamp default now()
);
 end;
$$

-- Q1 : Show total number of rows using function
create function get_count()
returns int
language plpgsql
as
$$
  declare
   tot_count int;
  begin
   select count(*) into tot_count from students;
  return tot_count;
  end;
$$

-- when it is necessary to see the result just
select get_count();

-- when other tasks depend on the result then apply it
select createDebug_log();

do $$
  declare
   tot_count int;
  begin
   select get_count() into tot_count;  
   if tot_count=0 then
    insert into debug_log(msg) values ('No student found');
   else
    insert into debug_log(msg) values ('Total students: ' || tot_count);
   end if;
  end;
$$

drop function get_count;
drop function  createDebug_log;
drop table debug_log;

-- Q2 : Now Exactly do the same thing using procedure
create procedure get_count(inout result int default null)
language plpgsql
as
$$
  declare
   tot_count int;
  begin
   select count(*) into tot_count from students;
   result :=tot_count;
  end;
$$

-- when it is necessary to see the result just
call get_count(null);

-- when other tasks depend on the result then apply it
create function createDebug_log()
returns void
language plpgsql
as 
$$
 begin
 create table if not exists debug_log(
  msg text,
  created_at timestamp default now()
);
 end;
$$
  
select createDebug_log();

do $$
  declare
   result int;
  begin
   call get_count(result);
   if result=0 then
     insert into debug_log(msg) values ('No student found');
   else
     insert into debug_log(msg) values ('Total students: ' || result);
  end if;
  end;
$$

drop procedure get_count;
drop function createDebug_log;
drop table debug_log;
drop table students;