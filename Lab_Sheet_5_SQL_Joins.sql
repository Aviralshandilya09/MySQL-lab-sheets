-- LAB SHEET 5: SQL JOINS
-- MySQL Workbench compatible
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Course;

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Location VARCHAR(50)
);
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50),
    Duration VARCHAR(30)
);
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Dept_ID INT NULL,
    Course_ID INT NULL
);
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Manager_ID INT NULL
);

INSERT INTO Department VALUES
(1, 'IT', 'Delhi'),
(2, 'HR', 'Noida'),
(3, 'Sales', 'Haridwar'),
(4, 'Finance', 'Dehradun');

INSERT INTO Course VALUES
(1, 'BTech', '4 years'),
(2, 'BCA', '3 years'),
(3, 'BBA', '3 years');

INSERT INTO Student VALUES
(1, 'Aman', 1, 1),
(2, 'Riya', 2, 2),
(3, 'Karan', 1, 1),
(4, 'Neha', NULL, 3),
(5, 'Dev', 3, NULL);

INSERT INTO Employee VALUES
(101, 'Vikas', 'IT', 60000, NULL),
(102, 'Priya', 'HR', 50000, 101),
(103, 'Mohit', 'IT', 65000, 101),
(104, 'Anjali', 'Sales', 40000, 102);

-- 1. INNER JOIN Student and Department
SELECT s.Name, d.Dept_Name
FROM Student s INNER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 2. Student names with department names
SELECT s.Name AS Student_Name, d.Dept_Name
FROM Student s INNER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 3. Employee names with department names (matching department text)
SELECT e.Emp_Name, d.Dept_Name
FROM Employee e INNER JOIN Department d ON e.Department = d.Dept_Name;

-- 4. Students with course details
SELECT s.Name, c.Course_Name, c.Duration
FROM Student s INNER JOIN Course c ON s.Course_ID = c.Course_ID;

-- 5. Students in a particular department
SELECT s.Name, d.Dept_Name
FROM Student s INNER JOIN Department d ON s.Dept_ID = d.Dept_ID
WHERE d.Dept_Name = 'IT';

-- 6. LEFT OUTER JOIN
SELECT s.Name, d.Dept_Name
FROM Student s LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 7. All students, even without a matching department
SELECT s.Name, d.Dept_Name
FROM Student s LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 8. RIGHT OUTER JOIN
SELECT s.Name, d.Dept_Name
FROM Student s RIGHT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 9. All departments, including departments with no students
SELECT d.Dept_Name, s.Name
FROM Student s RIGHT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 10. Students not assigned to any department
SELECT s.Name
FROM Student s LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID
WHERE d.Dept_ID IS NULL;

-- 11. Departments having no students
SELECT d.Dept_Name
FROM Department d LEFT JOIN Student s ON d.Dept_ID = s.Dept_ID
WHERE s.Student_ID IS NULL;

-- 12. FULL OUTER JOIN workaround in MySQL: LEFT JOIN + RIGHT JOIN with UNION
SELECT s.Name, d.Dept_Name
FROM Student s LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID
UNION
SELECT s.Name, d.Dept_Name
FROM Student s RIGHT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 13. CROSS JOIN Student and Course
SELECT s.Name, c.Course_Name
FROM Student s CROSS JOIN Course c;

-- 14. Number of possible Student-Course combinations
SELECT COUNT(*) AS Total_Combinations
FROM Student CROSS JOIN Course;

-- 15. NATURAL JOIN example (both tables have Dept_ID)
SELECT Name, Dept_Name
FROM Student NATURAL JOIN Department;

-- 16. Compare NATURAL JOIN and INNER JOIN
SELECT s.Name, d.Dept_Name
FROM Student s INNER JOIN Department d ON s.Dept_ID = d.Dept_ID;

SELECT Name, Dept_Name
FROM Student NATURAL JOIN Department;

-- 17. SELF JOIN to show employee-manager relationships
SELECT e.Emp_Name AS Employee, m.Emp_Name AS Manager
FROM Employee e LEFT JOIN Employee m ON e.Manager_ID = m.Emp_ID;

-- 18. Employees along with their managers
SELECT e.Emp_Name, m.Emp_Name AS Manager_Name
FROM Employee e LEFT JOIN Employee m ON e.Manager_ID = m.Emp_ID;

-- 19. Join Student, Department and Course
SELECT s.Name, d.Dept_Name, c.Course_Name
FROM Student s
LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID
LEFT JOIN Course c ON s.Course_ID = c.Course_ID;

-- 20. Student name, course name and department name
SELECT s.Name AS Student_Name, c.Course_Name, d.Dept_Name
FROM Student s
LEFT JOIN Course c ON s.Course_ID = c.Course_ID
LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 21. Employees earning more than average salary of their department
SELECT e.Emp_Name, e.Department, e.Salary
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.Department = e.Department
);

-- 22. Department with the maximum number of students
SELECT d.Dept_Name, COUNT(s.Student_ID) AS Total_Students
FROM Department d LEFT JOIN Student s ON d.Dept_ID = s.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
HAVING COUNT(s.Student_ID) = (
    SELECT MAX(student_count)
    FROM (
        SELECT COUNT(s2.Student_ID) AS student_count
        FROM Department d2 LEFT JOIN Student s2 ON d2.Dept_ID = s2.Dept_ID
        GROUP BY d2.Dept_ID
    ) AS counts
);

-- 23. Departments and total students in each
SELECT d.Dept_Name, COUNT(s.Student_ID) AS Total_Students
FROM Department d LEFT JOIN Student s ON d.Dept_ID = s.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name;

-- 24. Courses with number of students enrolled
SELECT c.Course_Name, COUNT(s.Student_ID) AS Total_Students
FROM Course c LEFT JOIN Student s ON c.Course_ID = s.Course_ID
GROUP BY c.Course_ID, c.Course_Name;

-- 25. Report using INNER JOIN, LEFT JOIN, GROUP BY and aggregate function
SELECT d.Dept_Name, c.Course_Name, COUNT(s.Student_ID) AS Total_Students
FROM Department d
LEFT JOIN Student s ON d.Dept_ID = s.Dept_ID
LEFT JOIN Course c ON s.Course_ID = c.Course_ID
GROUP BY d.Dept_ID, d.Dept_Name, c.Course_ID, c.Course_Name
ORDER BY d.Dept_Name, c.Course_Name;
