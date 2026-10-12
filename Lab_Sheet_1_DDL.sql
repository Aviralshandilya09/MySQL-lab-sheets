-- LAB SHEET 1: DDL COMMANDS - CREATE, ALTER AND DROP
-- MySQL Workbench compatible
-- Run this file from top to bottom. Destructive examples are placed at the end.

CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- 1. Create Student table
CREATE TABLE IF NOT EXISTS Student (
    Student_ID INT,
    Name VARCHAR(50),
    Age INT,
    Course VARCHAR(50),
    City VARCHAR(50)
);

-- 2. Create Employee table
CREATE TABLE IF NOT EXISTS Employee (
    Emp_ID INT,
    Emp_Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 3. Create Department table
CREATE TABLE IF NOT EXISTS Department (
    Dept_ID INT,
    Dept_Name VARCHAR(50),
    Location VARCHAR(50)
);

-- 4. Create Product table
CREATE TABLE IF NOT EXISTS Product (
    Product_ID INT,
    Product_Name VARCHAR(50),
    Price DECIMAL(10,2),
    Quantity INT
);

-- 5. Create Customer table
CREATE TABLE IF NOT EXISTS Customer (
    Customer_ID INT,
    Customer_Name VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

-- 6. Create Course table
CREATE TABLE IF NOT EXISTS Course (
    Course_ID INT,
    Course_Name VARCHAR(50),
    Duration VARCHAR(30),
    Fees DECIMAL(10,2)
);

-- 7. Create Faculty table
CREATE TABLE IF NOT EXISTS Faculty (
    Faculty_ID INT,
    Faculty_Name VARCHAR(50),
    Subject VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 8. Create Library table
CREATE TABLE IF NOT EXISTS Library (
    Book_ID INT,
    Book_Name VARCHAR(100),
    Author VARCHAR(50),
    Price DECIMAL(10,2)
);

-- 9. Department with Primary Key (separate example table)
CREATE TABLE IF NOT EXISTS Department_PK (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Location VARCHAR(50)
);

-- 10. Student with Primary Key and NOT NULL
CREATE TABLE IF NOT EXISTS Student_Constraints (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT,
    Course VARCHAR(50),
    City VARCHAR(50)
);

-- 11. Employee with UNIQUE Email
CREATE TABLE IF NOT EXISTS Employee_Constraints (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 12. Product with CHECK constraint
CREATE TABLE IF NOT EXISTS Product_Constraints (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price > 0),
    Quantity INT
);

-- 13. Add Email column to Student
ALTER TABLE Student ADD COLUMN Email VARCHAR(100);

-- 14. Add Phone column to Student
ALTER TABLE Student ADD COLUMN Phone VARCHAR(15);

-- 15. Modify Name column size
ALTER TABLE Student MODIFY COLUMN Name VARCHAR(100);

-- 16. Rename Student table
RENAME TABLE Student TO Student_Details;

-- 17. Rename City column to Address
ALTER TABLE Student_Details CHANGE COLUMN City Address VARCHAR(50);

-- 18. Add Salary column to Employee
ALTER TABLE Employee ADD COLUMN Salary_Bonus DECIMAL(10,2);

-- 19. Drop Phone column from Student_Details
ALTER TABLE Student_Details DROP COLUMN Phone;

-- 20. Drop Email column from Student_Details
ALTER TABLE Student_Details DROP COLUMN Email;

-- 21. TRUNCATE example: removes all rows but keeps table structure
CREATE TABLE IF NOT EXISTS Truncate_Demo (ID INT, Note VARCHAR(50));
INSERT INTO Truncate_Demo VALUES (1, 'Example row');
TRUNCATE TABLE Truncate_Demo;

-- 22. DROP Course table example
DROP TABLE IF EXISTS Course;

-- 23. DROP Customer table example
DROP TABLE IF EXISTS Customer;

-- 24. Complete Student table with constraints
CREATE TABLE IF NOT EXISTS Student_Complete (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Age INT CHECK (Age >= 16),
    Course VARCHAR(50),
    City VARCHAR(50)
);

-- 25. Suitable ALTER and DROP operations
ALTER TABLE Student_Complete ADD COLUMN Phone VARCHAR(15);
ALTER TABLE Student_Complete MODIFY COLUMN Name VARCHAR(100);
ALTER TABLE Student_Complete DROP COLUMN Phone;

-- View tables
SHOW TABLES;
DESCRIBE Student_Complete;
