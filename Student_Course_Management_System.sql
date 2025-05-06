--SQL Script for Student Course Management System
--Part 1: Create Database and Tables
-- Step 1: Create the database
CREATE DATABASE course_management;
--Step 2: Create Students Table
create table "Students" (
    student_id INT  primary key,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    date_of_birth DATE

);

--Create Instructors table
create table  Instructors (
    instructor_id INT primary key,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);
--Create Courses table with foreign key to Instructors
create table Courses (
    course_id INT primary key,
    course_name VARCHAR(100),
    course_description TEXT,
    instructor_id INT,
    foreign KEY(instructor_id) references Instructors(instructor_id)
);
--Create Enrollments table with foreign keys to Students and Courses
CREATE table Enrollments (
    enrollment_id INT primary key,
    student_id INT,
    Course_id INT,
    enrollment_date DATE,
    grade CHAR(1) CHECK(grade in ('A', 'B', 'C', 'D', 'F')),
    foreign KEY(student_id) references "Students"(student_id),
    foreign key (course_id) references Courses (course_id)
);
--Part 2: Insert Sample Data
--Step 3:Populate tables with sample Data
--Insert 10 students
insert into "Students" (student_id, first_name, last_name, email, date_of_birth) values 
 (1, 'Emma', 'Apiyo', 'emma.apiyo@email.com', '2000-03-15' );
 (2,  'Liam', 'Ounoi', 'liam.ounoi@email.com', '1999-07-22');
 (3, 'Olivia', 'Brown', 'olivia.brown@email.com','2001-01-10');
 (4, 'Noah', 'Davis', 'noah.davis@email.com', '2000-11-05');
 (5, 'Ava', 'Martinez', 'ava.martinez', '1999-09-18');
 (6, 'Sophia', 'Anderson', 'sophia.anderson@email.com', '2001-04-30');
 (7, 'Jackson', 'Taylor', 'jackson.taylor@email.com', '2000-06-12');
 (8, 'Isabella', 'Auma', 'isabella.auma@email.com', '1999-12-25');
 (9, 'Lucas', 'Moore', 'lucas.moore@email.com', '2001-02-08');
 (10, 'Mia', 'Khalif', 'mia.khalif@email.com', '2000-08-14');
--insert 3 instructors
insert into instructors (instructor_id, first_name, last_name, email) values 
 (1, 'John', 'Smith', 'john.smith@email.com');
 (2, 'Mary', 'Achieng', 'mary.achieng@email.com');
  (3, 'Robert', 'Williams', 'robert.williams@email.com');
--Insert 5 courses
insert into Courses (course_id, course_name, course_description, instructor_id) VALUES
 (1, 'Database Systems', 'Introduction to relational database', 1);
 (2, 'Web Development', 'Building modern web application', 2);
 (3, ' Data strcuctures', 'Fundamental data structures and algorithms', 1);
 (4, 'Machine Learning', 'Introduction to ML concepts', 3);
 (5, 'Software Engineering', 'Software development methodologies', 2);
--Insert 15 enrollments
SELECT course_id FROM Courses WHERE course_id IN (1, 2, 3, 4, 5);
SELECT student_id FROM "Students" WHERE student_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) VALUES
(1, 1, 1, '2023-01-10', 'A'),
(2, 1, 2, '2023-01-12', 'B'),
(3, 2, 1, '2023-01-10', 'C'),
(4, 2, 3, '2023-01-15', 'F'),
(5, 3, 2, '2023-01-12', 'A'),
(6, 3, 4, '2023-01-20', 'B'),
(7, 4, 3, '2023-01-15', 'D'),
(8, 5, 1, '2023-01-10', 'A'),
(9, 5, 5, '2023-01-25', 'F'),
(10, 6, 2, '2023-01-12', 'C'),
(11, 7, 4, '2023-01-20', 'B'),
(12, 8, 1, '2023-01-10', 'F'),
(13, 8, 3, '2023-01-15', 'F'),
(14, 9, 5, '2023-01-25', 'A'),
(15, 10, 2, '2023-01-12', 'D');
--Part 3: Write SQL Queries
--Step 4: Execute the required Queries
--Query 1: Student who enrolled in at least one course
-- Query 1: Students who enrolled in at least one course
SELECT DISTINCT s.student_id, s.first_name, s.last_name
FROM "Students" s
JOIN Enrollments e ON s.student_id = e.student_id;
--Query 2: Students enrolled in more than two courses
select s.student_id, s.first_name, s.last_name, COUNT(e.student_id) as course_count
from "Students" s 
join Enrollments e on s.student_id = e.student_id
group by s.student_id, s.first_name, s.last_name 
having Count(e.course_id) > 
--Query 3: Courses with total enrolled students
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_students 
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;
--Query 4: Average grade per course (A=4, B=3, C=2, D=1, F=0)
select c.course_id, c.course_name,
       AVG(case e.grade
           when 'A' then 4
           when 'B' then 3
           when 'C' then 2
           when 'D' then 1
           when 'F' then 0
           END) as avg_grade
from Courses c
left join Enrollments e on c.course_id = e.course_id
where e.grade is not null
group by c.course_id, c.course_name;
--Query 5: Students who haven't enrolled in any course
select s.student_id, s.first_name, s.last_name
from "Students" s
left join Enrollments e on s.student_id = e.student_id
where e.student_id is null;
--Query 6: Students with their average grade across all courses
select s.student_id, s.first_name, s.last_name,
       AVG(case e.grade
       when 'A' then 4
       when 'B' then 3
       when 'C' then 2
       when 'D' then 1
       when 'F' then 0
       END) as avg_grade
       from "Students" s
       left join Enrollments e on s.student_id = e.student_id
       where e.grade is not NULL
       group by s.student_id, s.first_name, s.last_name;
--Query 7: Instructors with the number of courses they teach
select i.instructor_id, i.first_name, i.last_name, COUNT(c.course_id) as 
course_count
from Instructors i
left join Courses c on i.instructor_id = c.instructor_id
group by i.instructor_id, i.first_name, i.last_name;
--Query 8: Students enrolled in a course taught by "John Smith"
select distinct s.student_id, s.first_name, s.last_name
from "Students" s
join Enrollments e on s.student_id = e.student_id
join Courses c on e.course_id = c.course_id
join Instructors i on c.instructor_id = i.instructor_id
where i.first_name = 'John' and i.last_name = 'Smith';
--Query 9: Top 3 students by average grade
select s.student_id, s.first_name, s.last_name,
       AVG(case e.grade
       when 'A' then 4
       when 'B' then 3
       when 'C' then 2
       when 'D' then 1
       when 'F' then 0
       END) as avg_grade
from "Students" s
join Enrollments e on s.student_id = e.student_id
group by s.student_id, s.first_name, s.last_name
order by avg_grade desc 
limit 3;
--Query 10: Students failing (grade = 'F') in more than one course
select s.student_id, s.first_name, s.last_name, COUNT(*) as fail_count
from "Students" s
join Enrollments e on s.student_id = e.student_id
where e.grade = 'F'
group by s.student_id, s.first_name, s.last_name
having COUNT(*) > 1;
--Part 4: Advanced SQL
--Step 5: Create advanced SQL components
--Create VIEW for student course summary
create view student_course_summary as 
select s.first_name || '' || s.last_name as student_name,
       c.course_name,
       e.grade
from "Students" s
join Enrollments e on s.student_id = e.student_id
join courses c on e.course_id = c.course_id;
--Create INDEX on Enrollments.student_id
-- Drop the existing index if it exists
DROP INDEX IF EXISTS idx_enrollments_student_id;

-- Create INDEX on Enrollments.student_id
CREATE INDEX idx_enrollments_student_id ON Enrollments(student_id);

-- Create table for logging new enrollments
CREATE TABLE IF NOT EXISTS enrollment_log (
    log_id SERIAL PRIMARY KEY,
    enrollment_id INT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create or replace function to log new enrollments
CREATE OR REPLACE FUNCTION log_enrollment()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO enrollment_log (enrollment_id, student_id, course_id, enrollment_date)
    VALUES (NEW.enrollment_id, NEW.student_id, NEW.course_id, NEW.enrollment_date);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to log new enrollments
CREATE TRIGGER enrollment_trigger
AFTER INSERT ON Enrollments
FOR EACH ROW
EXECUTE FUNCTION log_enrollment();