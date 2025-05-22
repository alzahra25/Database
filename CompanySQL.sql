Create database company_task
--

use company_task

CREATE TABLE Employees (
  SSn INT PRIMARY KEY,
  Mname VARCHAR(50) NOT NULL,
  Lname VARCHAR(50) NOT NULL,
  Fname VARCHAR(50),
  Gender bit default 0,
  Bdate date,
  EmployeeAddress nvarchar(100),
  salary int CONSTRAINT CK_employee_salary CHECK(salary between 500 and 3500),
  super_ssn int,
  foreign key (super_ssn) references Employees(SSn)

);

CREATE TABLE Department (
  DUNM VARCHAR(50) PRIMARY KEY,
  SSN INT,
  HIRDATE DATE,
  Dname VARCHAR(50),
  FOREIGN KEY (SSN) REFERENCES Employees(SSN)
);

CREATE TABLE Locatiion (
  DUNM VARCHAR(50),
  Locatiion VARCHAR(50),
  PRIMARY KEY (DUNM, Locatiion),
  FOREIGN KEY (DUNM) REFERENCES Department(DUNM)
);

CREATE TABLE PROJECT (
  PNUM INT PRIMARY KEY,
  PN VARCHAR(100),
  LOC VARCHAR(50),
  CITY VARCHAR(50),
  DUNM VARCHAR(50),
  FOREIGN KEY (DUNM) REFERENCES Department(DUNM)
);