-- 📌 Exercise 7: Packages – Customer, Employee, and Account Operations
-- Author: Bhavana

--------------------------------------------------------------------------------
-- 🔹 Package 1: CustomerManagement
--------------------------------------------------------------------------------

-- Package Spec
CREATE OR REPLACE PACKAGE CustomerManagement IS
  PROCEDURE AddCustomer(p_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER);
  PROCEDURE UpdateCustomer(p_id NUMBER, p_name VARCHAR2);
  FUNCTION GetCustomerBalance(p_id NUMBER) RETURN NUMBER;
END;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY CustomerManagement IS
  PROCEDURE AddCustomer(p_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER) IS
  BEGIN
    INSERT INTO EX1_Customers(CustomerID, Name, DOB, Balance, LastModified, IsVIP)
    VALUES (p_id, p_name, p_dob, p_balance, SYSDATE, 'FALSE');
    COMMIT;
  END;

  PROCEDURE UpdateCustomer(p_id NUMBER, p_name VARCHAR2) IS
  BEGIN
    UPDATE EX1_Customers
    SET Name = p_name, LastModified = SYSDATE
    WHERE CustomerID = p_id;
    COMMIT;
  END;

  FUNCTION GetCustomerBalance(p_id NUMBER) RETURN NUMBER IS
    v_balance NUMBER;
  BEGIN
    SELECT Balance INTO v_balance FROM EX1_Customers WHERE CustomerID = p_id;
    RETURN v_balance;
  END;
END;
/

--------------------------------------------------------------------------------
-- 🔹 Package 2: EmployeeManagement
--------------------------------------------------------------------------------

-- Package Spec
CREATE OR REPLACE PACKAGE EmployeeManagement IS
  PROCEDURE HireEmployee(p_id NUMBER, p_name VARCHAR2, p_position VARCHAR2,
                         p_salary NUMBER, p_dept VARCHAR2, p_hire_date DATE);
  PROCEDURE UpdateEmployee(p_id NUMBER, p_salary NUMBER);
  FUNCTION GetAnnualSalary(p_id NUMBER) RETURN NUMBER;
END;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY EmployeeManagement IS
  PROCEDURE HireEmployee(p_id NUMBER, p_name VARCHAR2, p_position VARCHAR2,
                         p_salary NUMBER, p_dept VARCHAR2, p_hire_date DATE) IS
  BEGIN
    INSERT INTO EX1_Employees(EmployeeID, Name, Position, Salary, Department, HireDate)
    VALUES (p_id, p_name, p_position, p_salary, p_dept, p_hire_date);
    COMMIT;
  END;

  PROCEDURE UpdateEmployee(p_id NUMBER, p_salary NUMBER) IS
  BEGIN
    UPDATE EX1_Employees
    SET Salary = p_salary
    WHERE EmployeeID = p_id;
    COMMIT;
  END;

  FUNCTION GetAnnualSalary(p_id NUMBER) RETURN NUMBER IS
    v_salary NUMBER;
  BEGIN
    SELECT Salary INTO v_salary FROM EX1_Employees WHERE EmployeeID = p_id;
    RETURN v_salary * 12;
  END;
END;
/

--------------------------------------------------------------------------------
-- 🔹 Package 3: AccountOperations
--------------------------------------------------------------------------------

-- Package Spec
CREATE OR REPLACE PACKAGE AccountOperations IS
  PROCEDURE OpenAccount(p_id NUMBER, p_cust_id NUMBER, p_type VARCHAR2, p_balance NUMBER);
  PROCEDURE CloseAccount(p_id NUMBER);
  FUNCTION GetTotalCustomerBalance(p_cust_id NUMBER) RETURN NUMBER;
END;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY AccountOperations IS
  PROCEDURE OpenAccount(p_id NUMBER, p_cust_id NUMBER, p_type VARCHAR2, p_balance NUMBER) IS
  BEGIN
    INSERT INTO EX1_Accounts(AccountID, CustomerID, AccountType, Balance, LastModified)
    VALUES (p_id, p_cust_id, p_type, p_balance, SYSDATE);
    COMMIT;
  END;

  PROCEDURE CloseAccount(p_id NUMBER) IS
  BEGIN
    DELETE FROM EX1_Accounts WHERE AccountID = p_id;
    COMMIT;
  END;

  FUNCTION GetTotalCustomerBalance(p_cust_id NUMBER) RETURN NUMBER IS
    v_total NUMBER;
  BEGIN
    SELECT NVL(SUM(Balance), 0)
    INTO v_total
    FROM EX1_Accounts
    WHERE CustomerID = p_cust_id;
    RETURN v_total;
  END;
END;
/

--------------------------------------------------------------------------------
-- 🧪 Test the Packages
--------------------------------------------------------------------------------

BEGIN
  DBMS_OUTPUT.PUT_LINE('-- Testing CustomerManagement --');
  CustomerManagement.AddCustomer(4, 'Test User', TO_DATE('2002-01-01', 'YYYY-MM-DD'), 7000);
  CustomerManagement.UpdateCustomer(4, 'Updated User');
  DBMS_OUTPUT.PUT_LINE('Balance: ' || CustomerManagement.GetCustomerBalance(4));

  DBMS_OUTPUT.PUT_LINE('-- Testing EmployeeManagement --');
  EmployeeManagement.HireEmployee(3, 'New Emp', 'Analyst', 40000, 'Finance', SYSDATE);
  EmployeeManagement.UpdateEmployee(3, 42000);
  DBMS_OUTPUT.PUT_LINE('Annual Salary: ' || EmployeeManagement.GetAnnualSalary(3));

  DBMS_OUTPUT.PUT_LINE('-- Testing AccountOperations --');
  AccountOperations.OpenAccount(5, 4, 'Savings', 5000);
  DBMS_OUTPUT.PUT_LINE('Total Balance: ' || AccountOperations.GetTotalCustomerBalance(4));
  AccountOperations.CloseAccount(5);
END;
/
