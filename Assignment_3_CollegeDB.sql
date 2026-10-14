-- DBMS Assignment 3: SQL Programming / Query Assignment
-- Database: CollegeDB
-- Run Q1 and Q2 first. Q3-Q9 use the same data.
-- Q4 changes/deletes records. Q10 is an independent integrated example;
-- run it separately or reset the database before running it.

-- =========================================================
-- Q1. Database and Table Creation (DDL)
-- =========================================================
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

CREATE TABLE IF NOT EXISTS Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Gender CHAR(1),
    Dept_ID INT,
    Marks INT,
    City VARCHAR(50),
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

DESC Department;
DESC Student;

-- =========================================================
-- Q2. Insert Records (DML)
-- Run these INSERT statements only once on a fresh database.
-- =========================================================
INSERT INTO Department (Dept_ID, Dept_Name) VALUES
(101, 'Computer Science'),
(102, 'AI & ML'),
(103, 'Cyber Security'),
(104, 'Data Science'),
(105, 'Information Technology');

INSERT INTO Student (Student_ID, Student_Name, Gender, Dept_ID, Marks, City) VALUES
(1, 'Aarav', 'M', 101, 85, 'Meerut'),
(2, 'Priya', 'F', 102, 92, 'Delhi'),
(3, 'Rahul', 'M', 103, 76, 'Roorkee'),
(4, 'Ananya', 'F', 102, 88, 'Meerut'),
(5, 'Karan', 'M', 101, 69, 'Delhi'),
(6, 'Neha', 'F', 104, 95, 'Noida'),
(7, 'Mohit', 'M', 103, 81, 'Meerut'),
(8, 'Simran', 'F', 105, 73, 'Ghaziabad'),
(9, 'Rohan', 'M', 104, 89, 'Delhi'),
(10, 'Pooja', 'F', 102, 78, 'Roorkee');

SELECT * FROM Department;
SELECT * FROM Student;

-- =========================================================
-- Q3. SELECT and Filtering
-- =========================================================
-- a. Display all student records
SELECT * FROM Student;

-- b. Display Student_ID, Student_Name, and Marks
SELECT Student_ID, Student_Name, Marks
FROM Student;

-- c. Students who scored more than 80 marks
SELECT * FROM Student
WHERE Marks > 80;

-- d. Students whose city is Delhi
SELECT * FROM Student
WHERE City = 'Delhi';

-- e. Students whose marks are between 70 and 90
SELECT * FROM Student
WHERE Marks BETWEEN 70 AND 90;

-- f. Students in descending order of marks
SELECT * FROM Student
ORDER BY Marks DESC;

-- =========================================================
-- Q4. UPDATE and DELETE
-- Note: These commands change the data.
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
DELETE FROM Student
WHERE Student_ID = 10;

-- e. Display the table after modifications
SELECT * FROM Student;

-- =========================================================
-- Q5. Aggregate Functions
-- =========================================================
-- a. Total number of students
SELECT COUNT(*) AS Total_Students FROM Student;

-- b. Total marks obtained by all students
SELECT SUM(Marks) AS Total_Marks FROM Student;

-- c. Average marks
SELECT AVG(Marks) AS Average_Marks FROM Student;

-- d. Highest marks
SELECT MAX(Marks) AS Highest_Marks FROM Student;

-- e. Lowest marks
SELECT MIN(Marks) AS Lowest_Marks FROM Student;

-- f. Number of students from Delhi
SELECT COUNT(*) AS Delhi_Students
FROM Student
WHERE City = 'Delhi';

-- g. Average marks of students from Meerut
SELECT AVG(Marks) AS Meerut_Average
FROM Student
WHERE City = 'Meerut';

-- =========================================================
-- Q6. GROUP BY and HAVING
-- =========================================================
-- a. Number of students in each department
SELECT Dept_ID, COUNT(*) AS Total_Students
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
SELECT Dept_ID, COUNT(*) AS Total_Students
FROM Student
GROUP BY Dept_ID
HAVING COUNT(*) > 1;

-- e. Departments whose average marks are greater than 80
SELECT Dept_ID, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Dept_ID
HAVING AVG(Marks) > 80;

-- =========================================================
-- Q7. SQL JOINs
-- =========================================================
-- a. Student name and department name using INNER JOIN
SELECT Student.Student_Name, Department.Dept_Name
FROM Student
INNER JOIN Department
ON Student.Dept_ID = Department.Dept_ID;

-- b. All students with their department names using LEFT JOIN
SELECT Student.Student_Name, Department.Dept_Name
FROM Student
LEFT JOIN Department
ON Student.Dept_ID = Department.Dept_ID;

-- c. All departments and students belonging to them using RIGHT JOIN
SELECT Student.Student_Name, Department.Dept_Name
FROM Student
RIGHT JOIN Department
ON Student.Dept_ID = Department.Dept_ID;

-- d. Student name, department name, and marks
SELECT Student.Student_Name, Department.Dept_Name, Student.Marks
FROM Student
INNER JOIN Department
ON Student.Dept_ID = Department.Dept_ID;

-- e. Students belonging to AI & ML department
SELECT Student.Student_Name
FROM Student
INNER JOIN Department
ON Student.Dept_ID = Department.Dept_ID
WHERE Department.Dept_Name = 'AI & ML';

-- =========================================================
-- Q8. Subqueries
-- =========================================================
-- a. Student(s) who obtained the highest marks
SELECT * FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);

-- b. Students who scored more than average marks
SELECT * FROM Student
WHERE Marks > (SELECT AVG(Marks) FROM Student);

-- c. Students in the same department as Priya
SELECT * FROM Student
WHERE Dept_ID = (
    SELECT Dept_ID
    FROM Student
    WHERE Student_Name = 'Priya'
);

-- d. Students whose marks are equal to the highest marks
SELECT * FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);

-- e. Students belonging to AI & ML using a subquery
SELECT * FROM Student
WHERE Dept_ID = (
    SELECT Dept_ID
    FROM Department
    WHERE Dept_Name = 'AI & ML'
);

-- =========================================================
-- Q9. Combined SQL Query Practice
-- =========================================================
-- a. Students scoring more than 80 and belonging to Delhi
SELECT Student_Name
FROM Student
WHERE Marks > 80 AND City = 'Delhi';

-- b. Department-wise average marks in descending order
SELECT Dept_ID, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Dept_ID
ORDER BY Average_Marks DESC;

-- c. Top 3 students according to marks
SELECT * FROM Student
ORDER BY Marks DESC
LIMIT 3;

-- d. Students scoring more than their department's average
SELECT S.Student_Name, S.Marks, S.Dept_ID
FROM Student AS S
WHERE S.Marks > (
    SELECT AVG(S2.Marks)
    FROM Student AS S2
    WHERE S2.Dept_ID = S.Dept_ID
);

-- e. Department having the highest average marks
SELECT Dept_ID, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Dept_ID
ORDER BY Average_Marks DESC
LIMIT 1;

-- f. Number of students from each city
SELECT City, COUNT(*) AS Total_Students
FROM Student
GROUP BY City;

-- =========================================================
-- Q10. Integrated SQL Problem
-- This section is intended to be run independently.
-- If running after Q1-Q9, do not recreate/reinsert into existing tables.
-- =========================================================
-- 1. Create a fresh database and tables for Q10 (uncomment the next
--    lines only if you want to reset the database and lose its current data).
-- DROP DATABASE IF EXISTS CollegeDB;
-- CREATE DATABASE CollegeDB;
-- USE CollegeDB;
-- Then rerun the CREATE TABLE statements from Q1.

-- 2. Insert the records using the INSERT statements from Q2.

-- 3. Display all students
SELECT * FROM Student;

-- 4. Display students with marks greater than 80
SELECT * FROM Student
WHERE Marks > 80;

-- 5. Update the marks of one student
UPDATE Student
SET Marks = 90
WHERE Student_ID = 1;

-- 6. Delete one student record
DELETE FROM Student
WHERE Student_ID = 10;

-- 7. Display student names with department names using JOIN
SELECT Student.Student_Name, Department.Dept_Name
FROM Student
INNER JOIN Department
ON Student.Dept_ID = Department.Dept_ID;

-- 8. Calculate average marks of each department
SELECT Dept_ID, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Dept_ID;

-- 9. Find the student having the highest marks using a subquery
SELECT * FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);

-- 10. Display departments having average marks greater than 80
SELECT Dept_ID, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Dept_ID
HAVING AVG(Marks) > 80;
