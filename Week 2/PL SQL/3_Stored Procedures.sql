-- 📌 Exercise 3: Stored Procedures – Monthly Interest, Bonus, Fund Transfer
-- Author: Bhavana

-- 🔹 Scenario 1: ProcessMonthlyInterest
-- Apply 1% interest to all savings accounts

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
  UPDATE EX1_Accounts
  SET Balance = Balance + (Balance * 0.01)
  WHERE AccountType = 'Savings';

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Monthly interest applied to all savings accounts.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Interest application failed: ' || SQLERRM);
END;
/

-- 🔹 Scenario 2: UpdateEmployeeBonus
-- Add a bonus percent to all employees in a department

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
  p_department IN VARCHAR2,
  p_bonus_pct  IN NUMBER
)
IS
BEGIN
  UPDATE EX1_Employees
  SET Salary = Salary + (Salary * p_bonus_pct / 100)
  WHERE Department = p_department;

  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No employees found in department ' || p_department);
  ELSE
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Bonus applied to employees in ' || p_department);
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Bonus update failed: ' || SQLERRM);
END;
/

-- 🔹 Scenario 3: TransferFunds
-- Transfer funds between two accounts if sufficient balance

CREATE OR REPLACE PROCEDURE TransferFunds(
  p_from_account_id IN NUMBER,
  p_to_account_id   IN NUMBER,
  p_amount          IN NUMBER
)
IS
  v_balance NUMBER;
BEGIN
  SELECT Balance INTO v_balance FROM EX1_Accounts WHERE AccountID = p_from_account_id;

  IF v_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20010, 'Insufficient funds in source account.');
  END IF;

  -- Deduct from source
  UPDATE EX1_Accounts
  SET Balance = Balance - p_amount
  WHERE AccountID = p_from_account_id;

  -- Add to target
  UPDATE EX1_Accounts
  SET Balance = Balance + p_amount
  WHERE AccountID = p_to_account_id;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
END;
/

-- 🧪 Test all procedures in one anonymous block

BEGIN
  DBMS_OUTPUT.PUT_LINE('-- Testing Monthly Interest --');
  ProcessMonthlyInterest;

  DBMS_OUTPUT.PUT_LINE('-- Testing Employee Bonus for HR --');
  UpdateEmployeeBonus('HR', 5);

  DBMS_OUTPUT.PUT_LINE('-- Testing Fund Transfer --');
  TransferFunds(2, 1, 200);
END;
/
