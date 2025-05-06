# Student_Course_Management_System
SQL script for managing a students database
#**Project Description**
This SQL project implements a Student Course Management System for an EdTech company, built using PostgreSQL and designed to run in DBeaver. It includes a complete database schema, sample data, complex queries, advanced SQL features, and proper documentation.
#**Instructions to Run**
.**Install PostgreSQL:** Ensure PostgreSQL is installed (version 14 or later recommended).
.**Set up DBeaver:** Install DBeaver and connect to your PostgreSQL server.
.**Create Database:**
Open DBeaver and create a new database named course_management.
Open a new SQL editor in DBeaver connected to course_management.
.**Execute SQL:**
Copy the contents of the SQL file (Student_Course_Management_System.sql).
Paste and execute the entire script in the DBeaver SQL editor.
Run the script sequentially to create tables, insert data, and execute queries.
.**Verify Results:**
Check the tables (Students, Instructors, Courses, Enrollments) for data.
Run individual queries to see results.
Verify the student_course_summary view and enrollment_log table.
#**Schema Explanation**
The database consists of four main tables:
.**Students:** Stores student information (ID, name, email, DOB).
.**Instructors:** Stores instructor details (ID, name, email).
.**Courses:** Contains course details (ID, name, description, instructor).
.**Enrollments:** Tracks student course registrations (ID, student, course, date, grade).
.Foreign keys ensure referential integrity, and constraints (e.g., UNIQUE email, CHECK for grades) maintain data quality.
#**Key Queries**
.**Students in at least one course:** Uses JOIN and DISTINCT to list enrolled students.
.**Students in >2 courses:** Groups enrollments by student with HAVING clause.
.**Courses with enrollment counts:** LEFT JOIN to include all courses, even those with zero enrollments.
.**Average grade per course:** Converts grades to numeric values (A=4, F=0) for averaging.
.**Non-enrolled students:** LEFT JOIN with NULL check to find students without enrollments.
.**Student average grades:** Calculates GPA-like average across courses per student.
.**Instructor course counts:** Counts courses per instructor, including those with zero courses.
.**Students under John Smith:** Joins tables to find students in courses taught by John Smith.
.**Top 3 students by grade:** Orders students by average grade, limited to three.
.**Students failing multiple courses:** Identifies students with multiple 'F' grades.
#**Advanced Features**
.**View:** student_course_summary combines student names, course names, and grades.
.**Index:** Improves query performance on Enrollments.student_id.
.**Trigger:** Logs new enrollments into enrollment_log table with timestamps.
#**Sample Output**
.**Query 1:** Lists all students with at least one enrollment (e.g., Emma Wilson, Liam Johnson).
.**Query 4:** Shows average grades (e.g., Database Systems: 2.67).
.**Query 9:** Top students (e.g., Emma Wilson with avg_grade 3.5).
.**View:** **SELECT * FROM student_course_summary** shows formatted student-course-grade data.
#**Challenges and Lessons Learned**
.**Challenge:** Ensuring grade conversion (A=4, F=0) was consistent across queries.
.**Solution:** Used CASE statements for reliable grade mapping.
.**Challenge:** Handling students with no enrollments in queries.
.**Solution:** Used LEFT JOINs to include all students/courses.
.**Lesson:** Indexes significantly improve query performance for large datasets.
.**Lesson:** Triggers are powerful for auditing but require careful function design.
