-- 2 tables : teachers, students

DROP DATABASE
  IF EXISTS firstDB;

CREATE DATABASE
  firstDB;
-- now select database firstDB

DROP TABLE IF EXISTS teacher;
CREATE TABLE IF NOT EXISTS teacher(
  id SERIAL,
  name VARCHAR(30)
);

DROP TABLE IF EXISTS
  students;

CREATE TABLE IF NOT EXISTS
  students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(30) UNIQUE NOT NULL,
    age SMALLINT,
    dob DATE,
    isActive BOOLEAN DEFAULT TRUE
  );

INSERT INTO
  students (name, email, age, dob, isActive)
VALUES
  (
    'Rahim Ahmed',
    'rahim.ahmed@gmail.com',
    20,
    '2005-03-15',
    TRUE
  ),
  (
    'Karim Uddin',
    'karim.uddin@gmail.com',
    22,
    '2003-07-22',
    TRUE
  ),
  (
    'Fatema Khatun',
    'fatema.khatun@gmail.com',
    21,
    '2004-01-10',
    TRUE
  ),
  (
    'Nusrat Jahan',
    'nusrat.jahan@gmail.com',
    19,
    '2006-05-18',
    TRUE
  ),
  (
    'Sakib Hasan',
    'sakib.hasan@gmail.com',
    23,
    '2002-11-02',
    TRUE
  ),
  (
    'Ayesha Siddika',
    'ayesha.siddika@gmail.com',
    20,
    '2005-09-25',
    TRUE
  ),
  (
    'Tanvir Islam',
    'tanvir.islam@gmail.com',
    24,
    '2001-12-30',
    FALSE
  ),
  (
    'Mehedi Hasan',
    'mehedi.hasan@gmail.com',
    22,
    '2003-04-14',
    TRUE
  ),
  (
    'Sharmin Akter',
    'sharmin.akter@gmail.com',
    21,
    '2004-08-07',
    TRUE
  ),
  (
    'Rafiul Islam',
    'rafiul.islam@gmail.com',
    19,
    '2006-02-28',
    TRUE
  ),
  (
    'Jannatul Ferdous',
    'jannatul.ferdous@gmail.com',
    20,
    '2005-06-19',
    TRUE
  ),
  (
    'Hasan Mahmud',
    'hasan.mahmud@gmail.com',
    23,
    '2002-10-11',
    FALSE
  ),
  (
    'Mim Akter',
    'mim.akter@gmail.com',
    18,
    '2007-01-05',
    TRUE
  ),
  (
    'Saiful Islam',
    'saiful.islam@gmail.com',
    25,
    '2000-09-09',
    TRUE
  ),
  (
    'Tania Sultana',
    'tania.sultana@gmail.com',
    21,
    '2004-12-01',
    TRUE
  );

-- Q1 : Rename the table teacher to teachers.
ALTER TABLE teacher RENAME TO teachers;

-- Q2 : Rename the column name to fullName in the teachers table.
ALTER TABLE teachers RENAME COLUMN name TO fullName;

-- Q3 : Change the data type of fullName to VARCHAR(50) in the teachers table.
ALTER TABLE teachers ALTER COLUMN fullname TYPE VARCHAR(50);

-- Q4 : Add a NOT NULL constraint to the fullName column in the teachers table.
ALTER TABLE teachers ALTER COLUMN fullname SET NOT NULL;

-- Q5 : Remove the NOT NULL constraint from the fullName column.
ALTER TABLE teachers ALTER COLUMN fullname DROP NOT NULL;

-- Q6 : Add a new column email of type VARCHAR(30) to the teachers table.
ALTER TABLE teachers ADD COLUMN email VARCHAR(30);

-- Q7 : Remove the email column from the teachers table.
ALTER TABLE teachers DROP COLUMN email;

-- Q8 : Add a primary key constraint on the id column of the teachers table.
ALTER TABLE teachers ADD CONSTRAINT pk_teachers_id PRIMARY KEY(id);

-- Q9 : Add a unique constraint on the email column of the teachers table.
ALTER TABLE teachers ADD CONSTRAINT unique_teachers_email UNIQUE(email);

-- Q10 : Display all records from the students table.
SELECT * FROM students;

-- Q11 : Display student names as Full Name and emails as Email from the students table.
SELECT name as "Full Name",email as "Email" FROM students;

-- Q12 : Display all students ordered by age in ascending order.
SELECT * FROM students ORDER BY age ASC;

-- Q13 : Display all distinct ages from the students table in ascending order.
SELECT DISTINCT age FROM students ORDER BY age ASC;

-- Q14 : Display all students whose age is not 20.
SELECT * FROM students WHERE NOT age=20;  
alternative answer can be , SELECT * FROM students WHERE age != 20;

-- Q15 : Display students whose age is greater than 20 and who are active.
SELECT * FROM students WHERE age>20 AND isactive=true;

-- Q16 : Display students who are either 20 years old or inactive.
SELECT * FROM students WHERE age=20 OR isactive=false;

-- Q17 : Display students whose date of birth is between 20-06-2005 and 11-10-2008.
SELECT * FROM students WHERE dob BETWEEN '2005-06-20' AND '2008-10-11';

-- Q18 : Display students whose names start with the letter A.
SELECT * FROM students WHERE name LIKE 'A%';

-- Q19 : Display students whose names start with a, ignoring case sensitivity.
SELECT * FROM students WHERE name ILIKE 'a%';

-- Q20 : Display students whose names end with the letter a.
SELECT * FROM students WHERE name LIKE '%a';

-- Q21 : Display students whose names contain the letter d anywhere.
SELECT * FROM students WHERE name LIKE '%d%';

-- Q22 : Display students whose names contain d followed by exactly three characters.
SELECT * FROM students WHERE name LIKE '%d___';

-- Q23 : Display all student names in uppercase.
SELECT UPPER(name) as "Name" FROM students;

-- Q24 : Display all student names in lowercase.
SELECT LOWER(name) as "Name" FROM students;

-- Q25 : Display student names and emails combined into a single column named Name_Email.
SELECT CONCAT(name,email) as "Name_Email" FROM students;

-- Q26 : Display the name and age of the youngest student.
SELECT name,age as "Min age" FROM students WHERE age=(SELECT MIN(age) FROM students);

-- Q27 : Display the name and age of the oldest student.
SELECT name,age as "Max age" FROM students WHERE age=(SELECT MAX(age) FROM students);

-- Q28 : Display the total sum of all students’ ages.
SELECT SUM(age) AS "Total_age" FROM students;

-- Q29 : Display the average age of students.
SELECT AVG(age) AS "Average_age" FROM students;

-- Q30 : Display the total number of distinct ages in the students table.
SELECT COUNT(DISTINCT age) AS "Total_Distinct_Age" FROM students;























