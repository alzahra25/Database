
CREATE DATABASE TraineeSystem;


USE TraineeSystem;



-- Trainees Table
CREATE TABLE Trainees (
 TraineeID INT PRIMARY KEY,
 FullName VARCHAR(100),
 Email VARCHAR(100),
 Program VARCHAR(50),
 GraduationDate DATE
);
-- Job Applicants Table
CREATE TABLE Applicants (
 ApplicantID INT PRIMARY KEY,
 FullName VARCHAR(100),
 Email VARCHAR(100),
 Source VARCHAR(20),
 AppliedDate DATE
);

-- Insert into Trainees
INSERT INTO Trainees VALUES
(1, 'Layla Al Riyami', 'layla.r@example.com', 'Full Stack .NET', '2025-04-30'),
(2, 'Salim Al Hinai', 'salim.h@example.com', 'Outsystems', '2025-03-15'),
(3, 'Fatma Al Amri', 'fatma.a@example.com', 'Database Admin', '2025-05-01');
-- Insert into Applicants
INSERT INTO Applicants VALUES
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'),
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'), 
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28');



-- 1. UNION - unique people (no duplicates)
SELECT FullName, Email FROM Trainees
UNION
SELECT FullName, Email FROM Applicants;

-- 2. UNION ALL - allows duplicates
SELECT FullName, Email FROM Trainees
UNION ALL
SELECT FullName, Email FROM Applicants;

-- 3. INTERSECT simulation using INNER JOIN
SELECT T.FullName, T.Email
FROM Trainees T
INNER JOIN Applicants A ON T.Email = A.Email;


-- 4. DELETE rows for a specific program
DELETE FROM Trainees WHERE Program = 'Outsystems';


-- 5. TRUNCATE entire Applicants table
TRUNCATE TABLE Applicants;


-- 6. DROP TABLE removes table entirely
DROP TABLE Applicants;


-- Transaction example with forced failure
BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO Applicants VALUES 
        (104, 'Zahra Al Amri', 'zahra.a@example.com', 'Referral', '2025-05-10');

    -- This will fail: duplicate primary key
    INSERT INTO Applicants VALUES 
        (104, 'Error User', 'error@example.com', 'Website', '2025-05-11');

    COMMIT; -- This won't run if error occurs
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Transaction rolled back due to error.';
END CATCH;
