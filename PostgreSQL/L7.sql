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
  ),
  (
    4,
    'John',
    'Smith',
    'john@email.com',
    NULL,
    'USA',
    '2023-02-10'
  ),
  (
    5,
    'Emma',
    'Brown',
    'emma@email.com',
    '01933333333',
    'UK',
    '2023-02-20'
  );

create procedure studentDeletion(id int)
language plpgsql
as
$$
  begin
   delete from students where student_id=id;
  end;
$$

create table if not exists deletedStudents(
  student_id int primary key,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(100),
  phone varchar(20),
  country varchar(50),
  enrollment_date date
);

create function insertDeletedStudent()
returns trigger
language plpgsql
as
$$
  begin
   insert into deletedStudents(student_id,first_name,last_name,email,phone,country,enrollment_date) values
    (old.student_id,old.first_name,old.last_name,old.email,old.phone,old.country,old.enrollment_date);
   return old;
  end;
$$

create trigger deleteStudents
after delete
on students
for each row
execute function insertDeletedStudent();

call studentDeletion(5);