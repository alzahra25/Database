CREATE DATABASE Aggregation;


USE Aggregation;


CREATE TABLE Instructors (
 InstructorID INT PRIMARY KEY,
 FullName VARCHAR(100),
 Email VARCHAR(100),
 JoinDate DATE
);
CREATE TABLE Categories (
 CategoryID INT PRIMARY KEY,
 CategoryName VARCHAR(50)
);
CREATE TABLE Courses (
 CourseID INT PRIMARY KEY,
 Title VARCHAR(100),
 InstructorID INT,
 CategoryID INT,
 Price DECIMAL(6,2),
 PublishDate DATE,
 FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
 FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
CREATE TABLE Students (
 StudentID INT PRIMARY KEY,
 FullName VARCHAR(100),
 Email VARCHAR(100),
 JoinDate DATE
);
CREATE TABLE Enrollments (
 EnrollmentID INT PRIMARY KEY,
 StudentID INT,
 CourseID INT,
 EnrollDate DATE,
 CompletionPercent INT,
 Rating INT CHECK (Rating BETWEEN 1 AND 5),
 FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
 FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


-- Instructors
INSERT INTO Instructors VALUES
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'),
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21');
-- Categories
INSERT INTO Categories VALUES
(1, 'Web Development'),
(2, 'Data Science'),
(3, 'Business');
-- Courses
INSERT INTO Courses VALUES
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'),
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'),
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'),
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01');
-- Students
INSERT INTO Students VALUES
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'),
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'),
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10');
-- Enrollments
INSERT INTO Enrollments VALUES
(1, 201, 101, '2023-04-10', 100, 5),
(2, 202, 102, '2023-04-15', 80, 4),
(3, 203, 101, '2023-04-20', 90, 4),
(4, 201, 102, '2023-04-22', 50, 3),
(5, 202, 103, '2023-04-25', 70, 4),
(6, 203, 104, '2023-04-28', 30, 2),
(7, 201, 104, '2023-05-01', 60, 3);



--Count total number of students
SELECT COUNT(*) AS TotalStudents FROM Students;

--Count total number of enrollments
SELECT COUNT(*) AS TotalEnrollments FROM Enrollments;

--Find average rating of each course
SELECT CourseID, AVG(Rating) AS AverageRating
FROM Enrollments
GROUP BY CourseID;

--Total number of courses per instructor
SELECT InstructorID, COUNT(*) AS TotalCourses
FROM Courses
GROUP BY InstructorID;

--Number of courses in each category
SELECT CategoryID, COUNT(*) AS CourseCount
FROM Courses
GROUP BY CategoryID;

--Number of students enrolled in each course
SELECT CourseID, COUNT(StudentID) AS StudentCount
FROM Enrollments
GROUP BY CourseID;

--Average course price per category
SELECT CategoryID, AVG(Price) AS AvgPrice
FROM Courses
GROUP BY CategoryID;

--Maximum course price
SELECT MAX(Price) AS MaxPrice FROM Courses;

--Min, Max, and Avg rating per course
SELECT CourseID,
       MIN(Rating) AS MinRating,
       MAX(Rating) AS MaxRating,
       AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID;

--Count how many students gave rating = 5
SELECT COUNT(*) AS Rating5Count
FROM Enrollments
WHERE Rating = 5;
-------------------------------------------------------------------------------------
-- 1. Average completion per course
SELECT 
    CourseID, 
    AVG(CompletionPercent) AS AvgCompletion 
FROM 
    Enrollments 
GROUP BY 
    CourseID;

-- 2. Students enrolled in more than 1 course
SELECT 
    StudentID 
FROM 
    Enrollments 
GROUP BY 
    StudentID 
HAVING 
    COUNT(CourseID) > 1;

-- 3. Revenue per course
SELECT 
    e.CourseID, 
    COUNT(*) * c.Price AS Revenue 
FROM 
    Enrollments e
JOIN 
    Courses c ON e.CourseID = c.CourseID 
GROUP BY 
    e.CourseID, c.Price;

-- 4. Instructor name + distinct students
SELECT 
    i.FullName, 
    COUNT(DISTINCT e.StudentID) AS DistinctStudents 
FROM 
    Enrollments e
JOIN 
    Courses c ON e.CourseID = c.CourseID 
JOIN 
    Instructors i ON c.InstructorID = i.InstructorID 
GROUP BY 
    i.FullName;

-- 5. Average enrollments per category
SELECT 
    c.CategoryID, 
    AVG(ec.EnrollCount) AS AvgEnrollments 
FROM 
    (SELECT CourseID, COUNT(*) AS EnrollCount 
     FROM Enrollments 
     GROUP BY CourseID) ec
JOIN 
    Courses c ON ec.CourseID = c.CourseID 
GROUP BY 
    c.CategoryID;

-- 6. Average course rating by instructor
SELECT 
    i.InstructorID, 
    AVG(e.Rating) AS AvgRating 
FROM 
    Enrollments e
JOIN 
    Courses c ON e.CourseID = c.CourseID 
JOIN 
    Instructors i ON c.InstructorID = i.InstructorID 
GROUP BY 
    i.InstructorID;

-- 7. Top 3 courses by enrollments
SELECT TOP 3
    CourseID,
    COUNT(*) AS Enrollments
FROM 
    Enrollments
GROUP BY 
    CourseID
ORDER BY 
    Enrollments DESC;

-- 8. Average days to complete 100% 

SELECT 
    CourseID, 
    AVG(CASE 
        WHEN CompletionPercent = 100 THEN 30 
        ELSE NULL 
    END) AS AvgDaysToComplete 
FROM 
    Enrollments 
GROUP BY 
    CourseID;

-- 9. % students who completed each course
SELECT 
    CourseID,
    COUNT(CASE WHEN CompletionPercent = 100 THEN 1 END) * 100.0 / COUNT(*) AS CompletionRate
FROM 
    Enrollments 
GROUP BY 
    CourseID;

-- 10. Courses published per year
SELECT 
    YEAR(PublishDate) AS PublishYear, 
    COUNT(*) AS CourseCount 
FROM 
    Courses 
GROUP BY 
    YEAR(PublishDate);
-----------------------------------------------------------------------

-- 1. Student with most completed courses
SELECT TOP 1
    StudentID,
    COUNT(*) AS CompletedCourses
FROM 
    Enrollments
WHERE 
    CompletionPercent = 100
GROUP BY 
    StudentID
ORDER BY 
    CompletedCourses DESC;

-- 2. Instructor earnings from enrollments
SELECT 
    i.InstructorID,
    SUM(c.Price) AS TotalEarnings
FROM 
    Enrollments e
JOIN 
    Courses c ON e.CourseID = c.CourseID
JOIN 
    Instructors i ON c.InstructorID = i.InstructorID
GROUP BY 
    i.InstructorID;

-- 3. Category average rating (≥ 4)
SELECT 
    c.CategoryID,
    AVG(e.Rating) AS AvgRating
FROM 
    Enrollments e
JOIN 
    Courses c ON e.CourseID = c.CourseID
GROUP BY 
    c.CategoryID
HAVING 
    AVG(e.Rating) >= 4;

-- 4. Students who rated below 3 more than once
SELECT 
    StudentID
FROM 
    Enrollments
WHERE 
    Rating < 3
GROUP BY 
    StudentID
HAVING 
    COUNT(*) > 1;

-- 5. Course with lowest average completion
SELECT TOP 1
    CourseID,
    AVG(CompletionPercent) AS AvgCompletion
FROM 
    Enrollments
GROUP BY 
    CourseID
ORDER BY 
    AvgCompletion ASC;

-- 6. Students enrolled in all courses by instructor 1
SELECT 
    e.StudentID
FROM 
    Enrollments e
JOIN 
    Courses c ON e.CourseID = c.CourseID
WHERE 
    c.InstructorID = 1
GROUP BY 
    e.StudentID
HAVING 
    COUNT(DISTINCT e.CourseID) = (
        SELECT COUNT(*) FROM Courses WHERE InstructorID = 1
    );

-- 7. Duplicate ratings check
SELECT 
    StudentID,
    CourseID,
    Rating,
    COUNT(*) AS DupCount
FROM 
    Enrollments
GROUP BY 
    StudentID, CourseID, Rating
HAVING 
    COUNT(*) > 1;

-- 8. Category with highest average rating
SELECT TOP 1
    c.CategoryID,
    AVG(e.Rating) AS AvgRating
FROM 
    Courses c
JOIN 
    Enrollments e ON c.CourseID = e.CourseID
GROUP BY 
    c.CategoryID
ORDER BY 
    AvgRating DESC;