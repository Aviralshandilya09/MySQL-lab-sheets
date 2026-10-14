/*
BTCS203T-AS02 — SQL Programming / Query Assignment
Database: CollegeDB
SQL dialect: MySQL

Note:
- Run this script in MySQL.
- Q4 and Q10 include UPDATE/DELETE examples that modify data.
- If you want to rerun the full script from the beginning, the database is dropped and recreated.
*/

DROP DATABASE IF EXISTS CollegeDB;
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- =========================================================
-- Q1. Database and Table Creation — DDL
-- =========================================================

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100) NOT NULL,
    Gender CHAR(1),
    Dept_ID INT,
    Marks INT,
    City VARCHAR(100),
    CONSTRAINT fk_student_department
        FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

-- Display table structures
DESCRIBE Department;
DESCRIBE Student;

-- =========================================================
-- Q2. Insert Records — DML
-- =========================================================

INSERT INTO Department (Dept_ID, Dept_Name) VALUES
(101, 'Computer Science'),
(102, 'AI & ML'),
(103, 'Cyber Security'),
(104, 'Data Science'),
(105, 'Information Technology');

INSERT INTO Student (Student_ID, Student_Name, Gender, Dept_ID, Marks, City) VALUES
(1, 'Aarav',  'M', 101, 85, 'Meerut'),
(2, 'Priya',  'F', 102, 92, 'Delhi'),
(3, 'Rahul',  'M', 103, 76, 'Roorkee'),
(4, 'Ananya', 'F', 102, 88, 'Meerut'),
(5, 'Karan',  'M', 101, 69, 'Delhi'),
(6, 'Neha',   'F', 104, 95, 'Noida'),
(7, 'Mohit',  'M', 103, 81, 'Meerut'),
(8, 'Simran', 'F', 105, 73, 'Ghaziabad'),
(9, 'Rohan',  'M', 104, 89, 'Delhi'),
(10, 'Pooja', 'F', 102, 78, 'Roorkee');

SELECT * FROM Department;
SELECT * FROM Student;

-- =========================================================
-- Q3. SELECT and Filtering
-- =========================================================

-- a. Display all student records
SELECT * FROM Student;

-- b. Display only Student_ID, Student_Name, and Marks
SELECT Student_ID, Student_Name, Marks
FROM Student;

-- c. Students who scored more than 80 marks
SELECT *
FROM Student
WHERE Marks > 80;

-- d. Students whose city is Delhi
SELECT *
FROM Student
WHERE City = 'Delhi';

-- e. Students whose marks are between 70 and 90 (inclusive)
SELECT *
FROM Student
WHERE Marks BETWEEN 70 AND 90;

-- f. Students in descending order of marks
SELECT *
FROM Student
ORDER BY Marks DESC;

-- =========================================================
-- Q4. UPDATE and DELETE
-- These commands change the table data.
-- =========================================================

-- a. Update Karan's marks from 69 to 75
UPDATE Student
SET Marks = 75
WHERE Student_Name = 'Karan';

-- b. Change Simran's city from Ghaziabad to Delhi
UPDATE Student
SET City = 'Delhi'
WHERE Student_Name = 'Simran';

-- c. Update Rahul's department to department 102
UPDATE Student
SET Dept_ID = 102
WHERE Student_Name = 'Rahul';

-- d. Delete the student whose Student_ID is 10
-- Uncomment the next line when you want to perform the deletion:
-- DELETE FROM Student WHERE Student_ID = 10;

-- e. Display the table after the modifications above
SELECT * FROM Student;

-- =========================================================
-- Q5. Aggregate Functions
-- =========================================================

-- a. Total number of students
SELECT COUNT(*) AS Total_Students
FROM Student;

-- b. Total marks obtained by all students
SELECT SUM(Marks) AS Total_Marks
FROM Student;

-- c. Average marks of students
SELECT AVG(Marks) AS Average_Marks
FROM Student;

-- d. Highest marks
SELECT MAX(Marks) AS Highest_Marks
FROM Student;

-- e. Lowest marks
SELECT MIN(Marks) AS Lowest_Marks
FROM Student;

-- f. Number of students from Delhi
SELECT COUNT(*) AS Students_From_Delhi
FROM Student
WHERE City = 'Delhi';

-- g. Average marks of students from Meerut
SELECT AVG(Marks) AS Average_Marks_Meerut
FROM Student
WHERE City = 'Meerut';

-- =========================================================
-- Q6. GROUP BY and HAVING
-- =========================================================

-- a. Number of students in each department
SELECT Dept_ID, COUNT(*) AS Student_Count
FROM Student
GROUP BY Dept_ID;

-- b. Average marks of each department
SELECT Dept_ID, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Dept_ID;

-- c. Highest marks in each department
SELECT Dept_ID, MAX(Marks) AS Highest_Marks
FROM Student
GROUP BY Dept_ID;

-- d. Departments having more than 1 student
SELECT Dept_ID, COUNT(*) AS Student_Count
FROM Student
GROUP BY Dept_ID
HAVING COUNT(*) > 1;

-- e. Departments whose average marks are greater than 80
SELECT Dept_ID, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Dept_ID
HAVING AVG(Marks) > 80;

-- Optional versions showing department names
SELECT d.Dept_Name, COUNT(s.Student_ID) AS Student_Count
FROM Department d
LEFT JOIN Student s ON s.Dept_ID = d.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
HAVING COUNT(s.Student_ID) > 1;

SELECT d.Dept_Name, AVG(s.Marks) AS Average_Marks
FROM Department d
JOIN Student s ON s.Dept_ID = d.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
HAVING AVG(s.Marks) > 80;

-- =========================================================
-- Q7. SQL JOINs
-- =========================================================

-- a. Student name and department name using INNER JOIN
SELECT s.Student_Name, d.Dept_Name
FROM Student s
INNER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- b. All students along with their department names using LEFT JOIN
SELECT s.Student_Name, d.Dept_Name
FROM Student s
LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- c. All departments and students belonging to them using RIGHT JOIN
SELECT d.Dept_Name, s.Student_Name
FROM Student s
RIGHT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- d. Student name, department name, and marks
SELECT s.Student_Name, d.Dept_Name, s.Marks
FROM Student s
INNER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- e. Students who belong to the AI & ML department
SELECT s.*
FROM Student s
INNER JOIN Department d ON s.Dept_ID = d.Dept_ID
WHERE d.Dept_Name = 'AI & ML';

-- =========================================================
-- Q8. Subqueries
-- =========================================================

-- a. Student(s) who obtained the highest marks
SELECT *
FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);

-- b. Students who scored more than the average marks of all students
SELECT *
FROM Student
WHERE Marks > (SELECT AVG(Marks) FROM Student);

-- c. Students in the same department as Priya (includes Priya)
SELECT *
FROM Student
WHERE Dept_ID = (
    SELECT Dept_ID
    FROM Student
    WHERE Student_Name = 'Priya'
);

-- d. Students whose marks are equal to the highest marks
SELECT *
FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);

-- e. Students in AI & ML using a subquery
SELECT *
FROM Student
WHERE Dept_ID = (
    SELECT Dept_ID
    FROM Department
    WHERE Dept_Name = 'AI & ML'
);

-- =========================================================
-- Q9. Combined SQL Query Practice
-- =========================================================

-- a. Students who scored more than 80 and belong to Delhi
SELECT Student_Name
FROM Student
WHERE Marks > 80
  AND City = 'Delhi';

-- b. Department-wise average marks in descending order
SELECT d.Dept_Name, AVG(s.Marks) AS Average_Marks
FROM Department d
JOIN Student s ON s.Dept_ID = d.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
ORDER BY Average_Marks DESC;

-- c. Top 3 students according to marks
SELECT *
FROM Student
ORDER BY Marks DESC
LIMIT 3;

-- d. Students whose marks are greater than their department's average
SELECT s.*
FROM Student s
WHERE s.Marks > (
    SELECT AVG(s2.Marks)
    FROM Student s2
    WHERE s2.Dept_ID = s.Dept_ID
);

-- e. Department having the highest average marks
SELECT d.Dept_Name, AVG(s.Marks) AS Average_Marks
FROM Department d
JOIN Student s ON s.Dept_ID = d.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
ORDER BY Average_Marks DESC
LIMIT 1;

-- f. Number of students from each city
SELECT City, COUNT(*) AS Student_Count
FROM Student
GROUP BY City;

-- =========================================================
-- Q10. Integrated SQL Problem
-- The database/tables/records were created in Q1 and Q2 above.
-- =========================================================

-- 3. Display all students
SELECT * FROM Student;

-- 4. Display students with marks greater than 80
SELECT *
FROM Student
WHERE Marks > 80;

-- 5. Update the marks of one student (example: Aarav)
UPDATE Student
SET Marks = 90
WHERE Student_ID = 1;

-- 6. Delete one student record
-- Uncomment the next line to perform the deletion:
-- DELETE FROM Student WHERE Student_ID = 10;

-- 7. Student names with department names using JOIN
SELECT s.Student_Name, d.Dept_Name
FROM Student s
INNER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 8. Average marks of each department
SELECT d.Dept_Name, AVG(s.Marks) AS Average_Marks
FROM Department d
LEFT JOIN Student s ON s.Dept_ID = d.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name;

-- 9. Student having the highest marks using a subquery
SELECT *
FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);

-- 10. Departments having an average mark greater than 80
SELECT d.Dept_Name, AVG(s.Marks) AS Average_Marks
FROM Department d
JOIN Student s ON s.Dept_ID = d.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
HAVING AVG(s.Marks) > 80;
