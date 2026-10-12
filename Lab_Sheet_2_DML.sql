-- LAB SHEET 2: DML COMMANDS - INSERT, UPDATE AND DELETE
-- MySQL Workbench compatible
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Course;

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
CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Location VARCHAR(50)
);
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Price DECIMAL(10,2),
    Quantity INT
);
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50),
    Duration VARCHAR(30),
    Fees DECIMAL(10,2)
);

-- 1. Insert one student
INSERT INTO Student VALUES (1, 'Aman', 19, 'BTech', 'Delhi');

-- 2. Insert five records using separate INSERT statements
INSERT INTO Student VALUES (2, 'Riya', 20, 'BCA', 'Meerut');
INSERT INTO Student VALUES (3, 'Karan', 19, 'BTech', 'Haridwar');
INSERT INTO Student VALUES (4, 'Neha', 21, 'BBA', 'Delhi');
INSERT INTO Student VALUES (5, 'Arjun', 20, 'BCA', 'Meerut');
INSERT INTO Student VALUES (6, 'Simran', 19, 'BTech', 'Roorkee');

-- 3. Insert multiple records in one statement
INSERT INTO Student (Student_ID, Name, Age, Course, City) VALUES
(7, 'Ishita', 20, 'BCA', 'Dehradun'),
(8, 'Rahul', 21, 'BTech', 'Delhi');

-- 4-8. Insert records into other tables
INSERT INTO Employee VALUES (101, 'Vikas', 'IT', 45000);
INSERT INTO Employee VALUES (102, 'Priya', 'HR', 40000);
INSERT INTO Employee VALUES (103, 'Mohit', 'IT', 52000);

INSERT INTO Department VALUES (1, 'IT', 'Delhi'), (2, 'HR', 'Noida');
INSERT INTO Product VALUES (1, 'Keyboard', 800, 10), (2, 'Mouse', 400, 0);
INSERT INTO Customer VALUES (1, 'Ankit', 'ankit@example.com', '9876543210');
INSERT INTO Course VALUES (1, 'BTech', '4 years', 80000), (2, 'BCA', '3 years', 50000);

-- 9. Insert a student with values for all columns
INSERT INTO Student VALUES (9, 'Meena', 20, 'BBA', 'Roorkee');

-- 10. Insert using selected columns only
INSERT INTO Student (Student_ID, Name, City) VALUES (10, 'Dev', 'Haridwar');

-- 11. Update city of a particular student
UPDATE Student SET City = 'Chandigarh' WHERE Student_ID = 1;

-- 12. Update salary of a particular employee
UPDATE Employee SET Salary = 48000 WHERE Emp_ID = 101;

-- 13. Increase salary of all employees by 10%
UPDATE Employee SET Salary = Salary * 1.10;

-- 14. Increase price of all products by 5%
UPDATE Product SET Price = Price * 1.05;

-- 15. Change course of a particular student
UPDATE Student SET Course = 'BTech' WHERE Student_ID = 2;

-- 16. Update department of an employee
UPDATE Employee SET Department = 'Finance' WHERE Emp_ID = 102;

-- 17. Change all students' city from Meerut to Delhi
UPDATE Student SET City = 'Delhi' WHERE City = 'Meerut';

-- 18. Update fees of a particular course
UPDATE Course SET Fees = 85000 WHERE Course_ID = 1;

-- 19. Update multiple columns together
UPDATE Student SET Age = 21, City = 'Dehradun' WHERE Student_ID = 3;

-- 20. Delete a particular student by Student_ID
DELETE FROM Student WHERE Student_ID = 10;

-- 21. Delete students belonging to a particular city
DELETE FROM Student WHERE City = 'Roorkee';

-- 22. Delete employees whose salary is below a specified amount
DELETE FROM Employee WHERE Salary < 42000;

-- 23. Delete products whose quantity is zero
DELETE FROM Product WHERE Quantity = 0;

-- 24. Delete using multiple conditions (AND / OR)
DELETE FROM Student WHERE (Age < 18 AND City = 'Delhi') OR Course = 'BBA';

-- 25. Display table after INSERT, UPDATE and DELETE operations
SELECT * FROM Student;
UPDATE Student SET City = 'Delhi' WHERE Student_ID = 1;
SELECT * FROM Student;
DELETE FROM Student WHERE Student_ID = 9;
SELECT * FROM Student;
