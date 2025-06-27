-- 📌 Exercise 2: Error Handling – Full Code with Execution
-- Author: Bhavana

-- 🔹 Procedure 1: SafeTransferFunds
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
  p_from_account_id IN NUMBER,
  p_to_account_id   IN NUMBER,
  p_amount          IN NUMBER
)
IS
  v_balance NUMBER;
BEGIN
  SELECT Balance INTO v_balance FROM EX1_Accounts WHERE AccountID = p_from_account_id;

  IF v_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the source account.');
  END IF;

  UPDATE EX1_Accounts
  SET Balance = Balance - p_amount
  WHERE AccountID = p_from_account_id;

  UPDATE EX1_Accounts
  SET Balance = Balance + p_amount
  WHERE AccountID = p_to_account_id;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Transfer successful.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
END;
/

-- 🔹 Procedure 2: UpdateSalary
CREATE OR REPLACE PROCEDURE UpdateSalary(
  p_emp_id IN NUMBER,
  p_percent IN NUMBER
)
IS
BEGIN
  UPDATE EX1_Employees
  SET Salary = Salary + (Salary * p_percent / 100)
  WHERE EmployeeID = p_emp_id;

  IF SQL%ROWCOUNT = 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Employee not found.');
  END IF;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Update failed: ' || SQLERRM);
END;
/

-- 🔹 Procedure 3: AddNewCustomer
CREATE OR REPLACE PROCEDURE AddNewCustomer(
  p_id IN NUMBER,
  p_name IN VARCHAR2,
  p_dob IN DATE,
  p_balance IN NUMBER
)
IS
BEGIN
  INSERT INTO EX1_Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
  VALUES (p_id, p_name, p_dob, p_balance, SYSDATE, 'FALSE');

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('New customer added successfully.');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Add failed: Customer ID ' || p_id || ' already exists.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

-- ✅ Now Call the Procedures (Execute Them)

BEGIN
  DBMS_OUTPUT.PUT_LINE('-- Testing Fund Transfer --');
  SafeTransferFunds(1, 2, 100);

  DBMS_OUTPUT.PUT_LINE('-- Testing Salary Update --');
  UpdateSalary(1, 10);

  DBMS_OUTPUT.PUT_LINE('-- Testing Add New Customer --');
  AddNewCustomer(3, 'Bhavana Test', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 5000);

  -- Duplicate to test error
  DBMS_OUTPUT.PUT_LINE('-- Testing Duplicate Customer Insert --');
  AddNewCustomer(3, 'Bhavana Test Again', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 5000);
END;
/
