-- LAB SHEET 3: SQL FUNCTIONS
-- MySQL Workbench compatible
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Employee;

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Course VARCHAR(50),
    City VARCHAR(50)
);
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Joining_Date DATE,
    First_Name VARCHAR(30),
    Last_Name VARCHAR(30)
);

INSERT INTO Student VALUES
(1, 'Aman Sharma', 19, 'BTech', 'Delhi'),
(2, 'Riya Verma', 20, 'BCA', 'Meerut'),
(3, 'Karan Singh', 21, 'BTech', 'Haridwar'),
(4, 'Neha Gupta', 20, 'BBA', 'Delhi');

INSERT INTO Employee VALUES
(101, 'Vikas Kumar', 'IT', 45500.75, '2024-01-15', 'Vikas', 'Kumar'),
(102, 'Priya Sharma', 'HR', 40000.40, '2023-06-20', 'Priya', 'Sharma'),
(103, 'Mohit Singh', 'IT', 52000.90, '2022-03-10', 'Mohit', 'Singh');

-- A. Number functions
-- 1. ABS()
SELECT ABS(-25) AS Absolute_Value;
-- 2. ROUND()
SELECT ROUND(125.678, 2) AS Rounded_Value;
-- 3. CEIL() and FLOOR()
SELECT CEIL(5.2) AS Ceiling_Value, FLOOR(5.8) AS Floor_Value;
-- 4. MOD()
SELECT MOD(10, 3) AS Remainder;
-- 5. Rounded employee salaries
SELECT Emp_Name, ROUND(Salary) AS Rounded_Salary FROM Employee;

-- B. Aggregate functions
-- 6. COUNT()
SELECT COUNT(*) AS Total_Students FROM Student;
-- 7. SUM()
SELECT SUM(Salary) AS Total_Salary FROM Employee;
-- 8. AVG()
SELECT AVG(Salary) AS Average_Salary FROM Employee;
-- 9. MAX()
SELECT MAX(Salary) AS Highest_Salary FROM Employee;
-- 10. MIN()
SELECT MIN(Salary) AS Lowest_Salary FROM Employee;

-- C. Character functions
-- 11. UPPER()
SELECT UPPER(Name) AS Upper_Name FROM Student;
-- 12. LOWER()
SELECT LOWER(Name) AS Lower_Name FROM Student;
-- 13. LENGTH()
SELECT Name, LENGTH(Name) AS Name_Length FROM Student;
-- 14. CONCAT()
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name FROM Employee;
-- 15. SUBSTRING()
SELECT Name, SUBSTRING(Name, 1, 4) AS Short_Name FROM Student;

-- D. Conversion functions
-- 16. Number to string
SELECT CAST(12345 AS CHAR) AS Number_As_String;
-- 17. String to number
SELECT CAST('250' AS DECIMAL(10,2)) AS String_As_Number;
-- 18. Format date in another format
SELECT DATE_FORMAT('2026-10-12', '%d-%m-%Y') AS Formatted_Date;
-- 19. CAST()
SELECT CAST('123.45' AS DECIMAL(10,2)) AS Converted_Value;
-- 20. CONVERT() in MySQL
SELECT CONVERT('2026-10-12', DATE) AS Converted_Date;

-- E. Date functions
-- 21. Current date
SELECT CURDATE() AS Current_Date;
-- 22. Extract year, month and day
SELECT YEAR(Joining_Date) AS Join_Year,
       MONTH(Joining_Date) AS Join_Month,
       DAY(Joining_Date) AS Join_Day
FROM Employee;
-- 23. Difference between two dates
SELECT DATEDIFF('2026-10-12', '2026-01-01') AS Days_Difference;
-- 24. Add days to a date
SELECT DATE_ADD('2026-10-12', INTERVAL 10 DAY) AS Date_After_10_Days;
-- 25. Display employee joining dates in required format
SELECT Emp_Name, DATE_FORMAT(Joining_Date, '%d/%m/%Y') AS Joining_Date
FROM Employee;
