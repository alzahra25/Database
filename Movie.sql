Create database Movie
--

use Movie

CREATE TABLE Users ( 
UserID INT PRIMARY KEY, 
FullName VARCHAR(100), 
JoinDate DATE, 
SubscriptionType VARCHAR(50) 
); 

CREATE TABLE Movies ( 
MovieID INT PRIMARY KEY, 
Title VARCHAR(100), 
Genre VARCHAR(50), 
ReleaseYear INT, 
DurationMinutes INT 
); 

CREATE TABLE WatchHistory ( 
WatchID INT PRIMARY KEY, 
UserID INT, 
MovieID INT, 
WatchDate DATE, 
WatchDuration INT);


-- Users 
INSERT INTO Users VALUES  
(1, 'Alice Johnson', '2023-01-15', 'Premium'), 
(2, 'Bob Smith', '2023-03-20', 'Standard'), 
(3, 'Charlie Lee', '2023-02-05', 'Basic'), 
(4, 'Diana Ray', '2023-04-10', 'Premium'), 
(5, 'Ethan Park', '2023-01-25', 'Standard');

-- Movies 
INSERT INTO Movies VALUES 
(101, 'The Great Heist', 'Action', 2022, 120), 
(102, 'Laugh Out Loud', 'Comedy', 2023, 90), 
(103, 'Deep Dive', 'Documentary', 2021, 75), 
(104, 'Speed Chase', 'Action', 2023, 110), 
(105, 'Tears of Time', 'Drama', 2020, 105);

-- WatchHistory 
INSERT INTO WatchHistory VALUES 
(1001, 1, 101, '2023-05-01', 115), 
(1002, 1, 102, '2023-05-02', 90), 
(1003, 2, 103, '2023-05-03', 75), 
(1004, 3, 104, '2023-05-01', 100), 
(1005, 4, 105, '2023-05-04', 105); 

--1--
SELECT FullName, SubscriptionType FROM Users;

--2--
SELECT Title, DurationMinutes FROM Movies;

--3--
SELECT * FROM WatchHistory;

--4--
SELECT Title, Genre FROM Movies WHERE ReleaseYear > 2020;

--5--
SELECT FullName FROM Users WHERE JoinDate > '2023-02-28';

--6--
SELECT Title FROM Movies WHERE DurationMinutes > 100;

--7--
SELECT * FROM WatchHistory WHERE UserID = 1;

--8--
SELECT FullName FROM Users ORDER BY JoinDate DESC;

--9--
SELECT * FROM Movies WHERE Genre = 'Action';

--10--
SELECT * FROM WatchHistory WHERE WatchDate = '2023-05-01';

--11--
SELECT * FROM Movies WHERE ReleaseYear = 2023;

--12--
SELECT FullName, SubscriptionType FROM Users WHERE SubscriptionType <> 'Basic';

--13--
SELECT * FROM Users WHERE FullName LIKE '%a%';

--14--
SELECT Title FROM Movies WHERE DurationMinutes = 90;

--15--
SELECT * FROM WatchHistory WHERE WatchDuration > 100;

--16--
SELECT FullName FROM Users 
WHERE MONTH(JoinDate) = 1 AND YEAR(JoinDate) = 2023;

--17--
SELECT * FROM Movies ORDER BY Title ASC;
