
CREATE DATABASE Job;

USE Job;


-- Company table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Industry VARCHAR(50),
    City VARCHAR(50)
);

-- Job Seekers Table
CREATE TABLE JobSeekers (
    SeekerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    ExperienceYears INT,
    City VARCHAR(50)
);

-- Jobs Table
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100),
    CompanyID INT,
    Salary DECIMAL(10, 2),
    Location VARCHAR(50),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

-- Applications Table
CREATE TABLE Applications (
    AppID INT PRIMARY KEY,
    JobID INT,
    SeekerID INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (SeekerID) REFERENCES JobSeekers(SeekerID)
);


-- Companies
INSERT INTO Companies VALUES
(1, 'TechWave', 'IT', 'Muscat'),
(2, 'GreenEnergy', 'Energy', 'Sohar'),
(3, 'EduBridge', 'Education', 'Salalah');

-- Job Seekers
INSERT INTO JobSeekers VALUES
(101, 'Sara Al Busaidi', 'sara.b@example.com', 2, 'Muscat'),
(102, 'Ahmed Al Hinai', 'ahmed.h@example.com', 5, 'Nizwa'),
(103, 'Mona Al Zadjali', 'mona.z@example.com', 1, 'Salalah'),
(104, 'Hassan Al Lawati', 'hassan.l@example.com', 3, 'Muscat');

-- Jobs
INSERT INTO Jobs VALUES
(201, 'Software Developer', 1, 900, 'Muscat'),
(202, 'Data Analyst', 1, 800, 'Muscat'),
(203, 'Science Teacher', 3, 700, 'Salalah'),
(204, 'Field Engineer', 2, 950, 'Sohar');

-- Applications
INSERT INTO Applications VALUES
(301, 201, 101, '2025-05-01', 'Pending'),
(302, 202, 104, '2025-05-02', 'Shortlisted'),
(303, 203, 103, '2025-05-03', 'Rejected'),
(304, 204, 102, '2025-05-04', 'Pending');


-- Task 1: Applicants who applied for jobs, with job title and company name.
SELECT 
    js.FullName AS ApplicantName,
    j.Title AS JobTitle,
    c.Name AS CompanyName
FROM Applications a
INNER JOIN JobSeekers js ON a.SeekerID = js.SeekerID
INNER JOIN Jobs j ON a.JobID = j.JobID
INNER JOIN Companies c ON j.CompanyID = c.CompanyID;

-- Task 2: All job titles and their company names, regardless of applications.
SELECT 
    j.Title AS JobTitle,
    c.Name AS CompanyName
FROM Jobs j
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID
LEFT JOIN Applications a ON j.JobID = a.JobID;

-- Task 3: Seekers who applied to jobs in their own city.
SELECT 
    js.FullName,
    j.Title AS JobTitle,
    js.City AS MatchingCity
FROM JobSeekers js
JOIN Applications a ON js.SeekerID = a.SeekerID
JOIN Jobs j ON a.JobID = j.JobID
WHERE js.City = j.Location;

-- Task 4: All job seekers with job titles they applied to, if any.
SELECT 
    js.FullName,
    j.Title AS JobTitle,
    a.Status
FROM JobSeekers js
LEFT JOIN Applications a ON js.SeekerID = a.SeekerID
LEFT JOIN Jobs j ON a.JobID = j.JobID;

-- Task 5: All job titles with applicant names (if any).
SELECT 
    j.Title AS JobTitle,
    js.FullName AS ApplicantName
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
LEFT JOIN JobSeekers js ON a.SeekerID = js.SeekerID;

-- Task 6: Job seekers who haven't applied to any job.
SELECT 
    js.FullName,
    js.Email
FROM JobSeekers js
LEFT JOIN Applications a ON js.SeekerID = a.SeekerID
WHERE a.AppID IS NULL;

-- Task 7: Companies with no jobs posted.
SELECT 
    c.Name,
    c.City
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.JobID IS NULL;

-- Task 8: Pairs of job seekers from the same city but different people.
SELECT 
    A.FullName AS Seeker1,
    B.FullName AS Seeker2,
    A.City AS SharedCity
FROM JobSeekers A
JOIN JobSeekers B ON A.City = B.City AND A.SeekerID <> B.SeekerID;

-- Task 9: Seekers who applied to jobs with salary > 850 in a different city.
SELECT 
    js.FullName,
    j.Title,
    j.Salary,
    js.City AS SeekerCity,
    j.Location AS JobCity
FROM JobSeekers js
JOIN Applications a ON js.SeekerID = a.SeekerID
JOIN Jobs j ON a.JobID = j.JobID
WHERE j.Salary > 850 AND js.City <> j.Location;

-- Task 10: Show seekers and job city they applied to.
SELECT 
    js.FullName,
    js.City AS SeekerCity,
    j.Location AS JobCity
FROM JobSeekers js
JOIN Applications a ON js.SeekerID = a.SeekerID
JOIN Jobs j ON a.JobID = j.JobID;

-- Task 11: Job titles with no applications.
SELECT 
    j.Title
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.AppID IS NULL;

-- Task 12: Seekers who applied to jobs in their own city.
SELECT 
    js.FullName,
    j.Title,
    js.City AS MatchingCity
FROM JobSeekers js
JOIN Applications a ON js.SeekerID = a.SeekerID
JOIN Jobs j ON a.JobID = j.JobID
WHERE js.City = j.Location;

-- Task 13: Two seekers from the same city applied to different jobs.
SELECT DISTINCT 
    js1.FullName AS Seeker1,
    js2.FullName AS Seeker2,
    js1.City
FROM JobSeekers js1
JOIN Applications a1 ON js1.SeekerID = a1.SeekerID
JOIN Jobs j1 ON a1.JobID = j1.JobID
JOIN JobSeekers js2 ON js1.City = js2.City AND js1.SeekerID <> js2.SeekerID
JOIN Applications a2 ON js2.SeekerID = a2.SeekerID
JOIN Jobs j2 ON a2.JobID = j2.JobID
WHERE j1.JobID <> j2.JobID;

-- Task 14: Applications where seeker city is different from job location.
SELECT 
    js.FullName,
    j.Title,
    js.City AS SeekerCity,
    j.Location AS JobLocation
FROM JobSeekers js
JOIN Applications a ON js.SeekerID = a.SeekerID
JOIN Jobs j ON a.JobID = j.JobID
WHERE js.City <> j.Location;

-- Task 15: Cities where seekers live but no companies are located.
SELECT DISTINCT 
    js.City
FROM JobSeekers js
LEFT JOIN Companies c ON js.City = c.City
WHERE c.CompanyID IS NULL;
