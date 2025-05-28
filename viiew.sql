CREATE DATABASE Viiew;


USE Viiew;


CREATE TABLE Customer (
 CustomerID INT PRIMARY KEY,
 FullName NVARCHAR(100),
 Email NVARCHAR(100),
 Phone NVARCHAR(15),
 SSN CHAR(9)
);
CREATE TABLE Account (
 AccountID INT PRIMARY KEY,
 CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
 Balance DECIMAL(10, 2),
 AccountType VARCHAR(50),
 Status VARCHAR(20)
);
CREATE TABLE Transactions (
 TransactionID INT PRIMARY KEY,
 AccountID INT FOREIGN KEY REFERENCES Account(AccountID),
 Amount DECIMAL(10, 2),
 Type VARCHAR(10),
 TransactionDate DATETIME
);
CREATE TABLE Loan (
 LoanID INT PRIMARY KEY,
 CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
 LoanAmount DECIMAL(12, 2),
 LoanType VARCHAR(50),
 Status VARCHAR(20)
);


INSERT INTO Customer (CustomerID, FullName, Email, Phone, SSN) VALUES
(1, 'Ahmed Al-Harthy', 'ahmed@example.com', '91234567', '123456789'),
(2, 'Fatima Al-Zahra', 'fatima@example.com', '92345678', '987654321'),
(3, 'Mohammed Al-Balushi', 'mohammed@example.com', '93456789', '456123789');

INSERT INTO Account (AccountID, CustomerID, Balance, AccountType, Status) VALUES
(101, 1, 1500.00, 'Savings', 'Active'),
(102, 1, 500.00, 'Checking', 'Inactive'),
(103, 2, 2500.75, 'Savings', 'Active'),
(104, 3, 100.00, 'Checking', 'Active');


INSERT INTO Transactions(TransactionID, AccountID, Amount, Type, TransactionDate) VALUES
(1001, 101, 200.00, 'Deposit', GETDATE()),
(1002, 103, 300.00, 'Withdraw', DATEADD(DAY, -10, GETDATE())),
(1003, 104, 150.00, 'Deposit', DATEADD(DAY, -40, GETDATE())),
(1004, 101, 50.00, 'Withdraw', DATEADD(DAY, -5, GETDATE()));

INSERT INTO Loan (LoanID, CustomerID, LoanAmount, LoanType, Status) VALUES
(201, 1, 10000.00, 'Personal', 'Approved'),
(202, 2, 20000.00, 'Home', 'Pending'),
(203, 3, 5000.00, 'Car', 'Rejected');


--1. Customer Service View
CREATE VIEW CustomerServiceView AS
SELECT 
    c.FullName, 
    c.Phone, 
    a.Status
FROM Customer c
JOIN Account a ON c.CustomerID = a.CustomerID;

--2. Finance Department View
CREATE VIEW FinanceView AS
SELECT 
    AccountID, 
    Balance, 
    AccountType
FROM Account;

--3. Loan Officer View
CREATE VIEW LoanOfficerView AS
SELECT 
    LoanID, 
    CustomerID, 
    LoanAmount, 
    LoanType, 
    Status
FROM Loan;


--4. Transaction Summary View
CREATE VIEW RecentTransactionsView AS
SELECT 
    AccountID, 
    Amount, 
    TransactionDate
FROM Transactions
WHERE TransactionDate >= DATEADD(DAY, -30, GETDATE());

-----------------------------------------------------------------
SELECT * FROM CustomerServiceView;
SELECT * FROM FinanceView;
SELECT * FROM LoanOfficerView;
SELECT * FROM RecentTransactionsView;