-- LAB SHEET 4: SQL OPERATORS
-- MySQL Workbench compatible
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Product;

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
    Salary DECIMAL(10,2)
);
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Price DECIMAL(10,2),
    Quantity INT
);

INSERT INTO Student VALUES
(1, 'Aman', 19, 'BTech', 'Delhi'),
(2, 'Riya', 20, 'BCA', 'Meerut'),
(3, 'Karan', 21, 'BTech', 'Haridwar'),
(4, 'Neha', 20, 'BBA', 'Delhi'),
(5, 'Dev', 18, 'BCA', 'Roorkee');

INSERT INTO Employee VALUES
(101, 'Vikas', 'IT', 45000),
(102, 'Priya', 'HR', 40000),
(103, 'Mohit', 'IT', 52000),
(104, 'Anjali', 'Sales', 35000);

INSERT INTO Product VALUES
(1, 'Keyboard', 800, 10),
(2, 'Mouse', 400, 5),
(3, 'Monitor', 7000, 2);

-- Arithmetic operators
-- 1. Addition
SELECT 10 + 5 AS Addition;
-- 2. Subtraction
SELECT 10 - 5 AS Subtraction;
-- 3. Multiplication
SELECT 10 * 5 AS Multiplication;
-- 4. Division
SELECT 10 / 5 AS Division;
-- 5. Price multiplied by quantity
SELECT Product_Name, Price, Quantity, Price * Quantity AS Total_Amount FROM Product;

-- Logical operators
-- 6. AND
SELECT * FROM Student WHERE Age >= 19 AND City = 'Delhi';
-- 7. OR
SELECT * FROM Student WHERE City = 'Delhi' OR City = 'Meerut';
-- 8. NOT
SELECT * FROM Student WHERE NOT City = 'Delhi';
-- 9. Course AND city
SELECT * FROM Student WHERE Course = 'BTech' AND City = 'Delhi';
-- 10. Either of two departments
SELECT * FROM Employee WHERE Department = 'IT' OR Department = 'HR';

-- Comparison operators
-- 11. =
SELECT * FROM Student WHERE City = 'Delhi';
-- 12. >
SELECT * FROM Employee WHERE Salary > 40000;
-- 13. <
SELECT * FROM Employee WHERE Salary < 40000;
-- 14. >= and <=
SELECT * FROM Student WHERE Age >= 18 AND Age <= 20;
-- 15. <> / !=
SELECT * FROM Student WHERE City <> 'Delhi';
SELECT * FROM Student WHERE City != 'Delhi';

-- Special operators
-- 16. BETWEEN
SELECT * FROM Employee WHERE Salary BETWEEN 35000 AND 50000;
-- 17. IN
SELECT * FROM Student WHERE City IN ('Delhi', 'Meerut');
-- 18. NOT IN
SELECT * FROM Student WHERE City NOT IN ('Delhi', 'Meerut');
-- 19. LIKE: names starting with A
SELECT * FROM Student WHERE Name LIKE 'A%';
-- 20. IS NULL and IS NOT NULL
SELECT * FROM Student WHERE Course IS NULL;
SELECT * FROM Student WHERE Course IS NOT NULL;

-- Set operations
-- 21. UNION removes duplicate values
SELECT City AS Place FROM Student WHERE City = 'Delhi'
UNION
SELECT City AS Place FROM Student WHERE City = 'Meerut';

-- 22. UNION ALL keeps duplicates
SELECT City AS Place FROM Student
UNION ALL
SELECT City AS Place FROM Student;

-- 23. MySQL versions before 8.0.31 do not support INTERSECT.
-- Use INNER JOIN as a workaround for common values:
SELECT DISTINCT s.City
FROM Student s
INNER JOIN (SELECT City FROM Student WHERE Course = 'BTech') b
ON s.City = b.City
WHERE s.Course = 'BCA';

-- 24. MySQL does not support EXCEPT in older versions; use NOT EXISTS as workaround:
SELECT DISTINCT City
FROM Student s
WHERE NOT EXISTS (
    SELECT 1 FROM Student b WHERE b.City = s.City AND b.Course = 'BTech'
);

-- 25. Multiple operators together
SELECT Product_Name, Price, Quantity, Price * Quantity AS Total_Amount
FROM Product
WHERE Price >= 400 AND Quantity > 0 AND Product_Name LIKE '%o%';
