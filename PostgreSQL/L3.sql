-- 3 tables students , courses, enrollments

drop database if exists thirdDB;
create database thirdDB;

--create students table
create table if not exists students (
  student_id int primary key,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  email varchar(100) not null,
  phone varchar(20),
  country varchar(50),
  enrollment_date date
);

--create courses table 
create table if not exists courses (
  course_id int primary key,
  course_title varchar(50),
  category varchar(50),
  price numeric(10, 2),
  instructor varchar(100),
  published_year int
);

--create enrollments table
create table if not exists enrollments (
  enrollment_id int primary key,
  student_id int references students (student_id),
  course_id int references courses (course_id),
  enrollment_date date,
  progress_percentage int,
  paid_amount numeric(10, 2)
);

--insert data into students table
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
  ),
  (
    6,
    'Ayaan',
    'Ali',
    'ayaan@email.com',
    NULL,
    'India',
    '2023-03-05'
  ),
  (
    7,
    'Lina',
    'Rahman',
    'lina@email.com',
    '01644444444',
    'Bangladesh',
    '2023-03-12'
  ),
  (
    8,
    'Mark',
    'Taylor',
    'mark@email.com',
    NULL,
    'Australia',
    '2023-03-25'
  ),
  (
    9,
    'Sophia',
    'Lee',
    'sophia@email.com',
    '01555555555',
    'USA',
    '2023-04-01'
  ),
  (
    10,
    'Daniel',
    'Martinez',
    'daniel@email.com',
    NULL,
    'Spain',
    '2023-04-10'
  );

--insert data into courses table
insert into
  courses (
    course_id,
    course_title,
    category,
    price,
    instructor,
    published_year
  )
values
  (
    1,
    'Complete SQL Bootcamp',
    'Database',
    49.99,
    'John Carter',
    2021
  ),
  (
    2,
    'Advanced JavaScript',
    'Programming',
    59.99,
    'Sarah Miller',
    2020
  ),
  (
    3,
    'Python for Data Science',
    'Data Science',
    69.99,
    'David Kim',
    2022
  ),
  (
    4,
    'Web Development with React',
    'Programming',
    54.99,
    'Emily Stone',
    2021
  ),
  (
    5,
    'Machine Learning Basics',
    'AI',
    79.99,
    'Andrew Ng',
    2019
  ),
  (
    6,
    'Cloud Computing Fundamentals',
    'Cloud',
    64.99,
    'James Allen',
    2020
  ),
  (
    7,
    'UI/UX Design Essentials',
    'Design',
    39.99,
    'Laura Scott',
    2022
  ),
  (
    8,
    'DevOps for Beginners',
    'DevOps',
    74.99,
    'Michael Brown',
    2023
  );

--insert into enrollments table
insert into
  enrollments (
    enrollment_id,
    student_id,
    course_id,
    enrollment_date,
    progress_percentage,
    paid_amount
  )
values
  (1, 1, 1, '2023-05-01', 80, 49.99),
  (2, 2, 2, '2023-05-03', NULL, 59.99),
  (3, 3, 3, '2023-05-05', 60, 69.99),
  (4, 4, 1, '2023-05-07', 100, 49.99),
  (5, 5, 4, '2023-05-10', 40, 54.99),
  (6, 6, 5, '2023-05-12', NULL, 79.99),
  (7, 7, 2, '2023-06-01', 90, 59.99),
  (8, 8, 6, '2023-06-02', 30, 64.99),
  (9, 9, 3, '2023-06-03', 70, 69.99),
  (10, 10, 7, '2023-06-04', NULL, 39.99),
  (11, 1, 8, '2023-06-05', 20, 74.99),
  (12, 2, 1, '2023-06-06', 50, 49.99),
  (13, 3, 6, '2023-06-07', NULL, 64.99),
  (14, 4, 4, '2023-06-08', 85, 54.99),
  (15, 5, 5, '2023-06-09', 60, 79.99);

-- Q1 : Display all students and their phone numbers.If the phone number is NULL, show 'Not Provided'.
select
  student_id,
  first_name,
  last_name,
  email,
  coalesce(phone, 'Not Provided') as "phone",
  country,
  enrollment_date
from
  students;

-- Q2 : Show all courses ordered by price (highest to lowest) and limit the result to 5 courses.
select
  *
from
  courses
order by
  price desc
limit
  5;

-- Q3 : Display courses for page 2, assuming 3 courses per page, using LIMIT and OFFSET.
select
  *
from
  courses
limit
  3
offset
  3 * 1;

-- Q4 : Update the price of all courses in the Programming category by increasing it 10%.
update courses
set
  price = price + price * 0.1
where
  category = 'Programming';

-- Q5 : Delete all enrollment records where progress_percentage is NULL.
delete from enrollments
where progress_percentage is null;

-- Q6 : Find the total paid amount per course category.
select
  c.category,
  sum(e.paid_amount)
from
  enrollments as e
  inner join courses as c on e.course_id = c.course_id
group by
  c.category;

alternatively you can write --

select
  category,
  sum(paid_amount)
from
  courses
  natural join enrollments
group by
  category;

-- Q7 : Show course categories where the average course price is greater than 60.
select
  category,
  avg(price) as "avg_price"
from
  courses
group by
  category
having
  avg(price) > 60;

-- Q8 : Count how many students are enrolled in each course.
select
  c.course_title,
  count(*) as "total_enrolled"
from
  courses as c
  inner join enrollments as e on c.course_id = e.course_id
group by
  c.course_title;

-- Q9 : Explain what happens if you try to insert an enrollment with a student_id that does not exist in the students table.


-- Q10 : Display student full name, course title, and paid amount.
select
  concat(s.first_name, ' ', s.last_name) as "full_name",
  c.course_title,
  e.paid_amount
from
  enrollments as e
  inner join students as s on e.student_id = s.student_id
  inner join courses as c on e.course_id = c.course_id;

-- Q11 : Display all students and their enrolled courses.Include students who have not enrolled in any course.
select
  s.first_name,
  s.last_name,
  c.course_title
from
  students as s
  left join enrollments as e on s.student_id = e.student_id
  left join courses as c on e.course_id = c.course_id;

-- Q12 : Display all courses and their enrolled students.Include courses that have no enrollments.
select
  c.course_title,
  concat(s.first_name, ' ', s.last_name) as "enrolled_student"
from
  enrollments as e
  right join courses as c on e.course_id = c.course_id
  left join students as s on s.student_id = e.student_id;

-- Q13 : Display all students and all courses, even if there is no matching enrollment.
select
  s.first_name,
  s.last_name,
  c.course_title
from
  students as s
  left join enrollments as e on s.student_id = e.student_id
  full join courses as c on e.course_id = c.course_id;

-- Q14: Show the number of enrollments per year based on enrollment_date.
select
  extract(
    year
    from
      enrollment_date
  ) as "year",
  count(*) as "total_enrollments"
from
  enrollments
group by
  extract(
    year
    from
      enrollment_date
  );

-- Q15 : Find the average progress percentage per course, ignoring NULL values.
select
  c.course_title,
  round(avg(e.progress_percentage), 2) as "avg_progress"
from
  enrollments as e
  inner join courses as c on e.course_id = c.course_id
group by
  c.course_title
order by
  c.course_title asc;

-- Q16 : Display all possible combinations of records from the students table and the enrollments table using cross join.
select * from students cross join enrollments;