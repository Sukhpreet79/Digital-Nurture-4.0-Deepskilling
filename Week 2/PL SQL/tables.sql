-- Create fresh tables for Exercise 1 (no dropping old ones)

CREATE TABLE EX1_Customers (
  CustomerID NUMBER PRIMARY KEY,
  Name VARCHAR2(100),
  DOB DATE,
  Balance NUMBER,
  LastModified DATE,
  IsVIP VARCHAR2(5)
);

CREATE TABLE EX1_Accounts (
  AccountID NUMBER PRIMARY KEY,
  CustomerID NUMBER,
  AccountType VARCHAR2(20),
  Balance NUMBER,
  LastModified DATE,
  FOREIGN KEY (CustomerID) REFERENCES EX1_Customers(CustomerID)
);

CREATE TABLE EX1_Transactions (
  TransactionID NUMBER PRIMARY KEY,
  AccountID NUMBER,
  TransactionDate DATE,
  Amount NUMBER,
  TransactionType VARCHAR2(10),
  FOREIGN KEY (AccountID) REFERENCES EX1_Accounts(AccountID)
);

CREATE TABLE EX1_Loans (
  LoanID NUMBER PRIMARY KEY,
  CustomerID NUMBER,
  LoanAmount NUMBER,
  InterestRate NUMBER,
  StartDate DATE,
  EndDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES EX1_Customers(CustomerID)
);

CREATE TABLE EX1_Employees (
  EmployeeID NUMBER PRIMARY KEY,
  Name VARCHAR2(100),
  Position VARCHAR2(50),
  Salary NUMBER,
  Department VARCHAR2(50),
  HireDate DATE
);
