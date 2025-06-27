-- Insert sample data into EX1_ tables

-- Customers
INSERT INTO EX1_Customers VALUES (1, 'John Doe', TO_DATE('1955-05-15', 'YYYY-MM-DD'), 1000, SYSDATE, 'FALSE');
INSERT INTO EX1_Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 15000, SYSDATE, 'FALSE');

-- Accounts
INSERT INTO EX1_Accounts VALUES (1, 1, 'Savings', 1000, SYSDATE);
INSERT INTO EX1_Accounts VALUES (2, 2, 'Checking', 1500, SYSDATE);

-- Transactions
INSERT INTO EX1_Transactions VALUES (1, 1, SYSDATE, 200, 'Deposit');
INSERT INTO EX1_Transactions VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

-- Loans
INSERT INTO EX1_Loans VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));
INSERT INTO EX1_Loans VALUES (2, 2, 3000, 6, SYSDATE + 5, ADD_MONTHS(SYSDATE + 5, 48));

-- Employees
INSERT INTO EX1_Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));
INSERT INTO EX1_Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

COMMIT;
