CREATE DATABASE baackup; 
 
USE baackup;

CREATE TABLE Students ( 
StudentID INT PRIMARY KEY, 
FullName NVARCHAR(100), 
EnrollmentDate DATE 
); 
INSERT INTO Students VALUES  
(1, 'Sara Ali', '2023-09-01'), 
(2, 'Mohammed Nasser', '2023-10-15');


-- Step 2.1: Full Backup
BACKUP DATABASE baackup TO DISK = 'C:\backups\TrainingDB_Full.bak';

-- Step 2.2: Simulate Change
INSERT INTO Students VALUES (3, 'Fatma Said', '2024-01-10');

-- Step 2.3: Differential Backup
BACKUP DATABASE baackup TO DISK = 'C:\backups\TrainingDB_Full.bak' WITH DIFFERENTIAL;

-- Step 2.4: Transaction Log Backup
ALTER DATABASE baackup SET RECOVERY FULL;
BACKUP LOG baackup TO DISK = 'C:\backups\TrainingDB_Log.trn';

-- Step 2.5: Copy-Only Backup
BACKUP DATABASE baackup TO DISK = 'C:\backups\TrainingDB_CopyOnly.bak' WITH COPY_ONLY;

---------------------------------------
--Part 3:
-- Full Backup (Sunday)
BACKUP DATABASE baackup TO DISK = 'C:\HospitalBackups\HospitalDB_Full_20240602.bak';

-- Differential Backup (Mon–Sat)
BACKUP DATABASE baackup TO DISK = 'C:\HospitalBackups\HospitalDB_Diff_20240603.bak' WITH DIFFERENTIAL;

-- Transaction Log Backup (Every Hour)
BACKUP LOG baackup TO DISK = 'C:\HospitalBackups\HospitalDB_Log_20240603_1300.trn';