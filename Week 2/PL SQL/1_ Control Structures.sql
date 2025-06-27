-- Prevent dropping below 0
BEGIN
  FOR cust IN (
    SELECT c.CustomerID
    FROM EX1_Customers c
    WHERE MONTHS_BETWEEN(SYSDATE, c.DOB) / 12 > 60
  ) LOOP
    UPDATE EX1_Loans
    SET InterestRate = CASE 
      WHEN InterestRate > 1 THEN InterestRate - 1 
      ELSE 0 
    END
    WHERE CustomerID = cust.CustomerID;
  END LOOP;
  COMMIT;
END;
/


-- 🔹 4. Scenario 2: Mark IsVIP = 'TRUE' for balance > 10000

BEGIN
  FOR cust IN (
    SELECT CustomerID FROM EX1_Customers WHERE Balance > 10000
  ) LOOP
    UPDATE EX1_Customers
    SET IsVIP = 'TRUE'
    WHERE CustomerID = cust.CustomerID;
  END LOOP;
  COMMIT;
END;
/

-- 🔹 5. Scenario 3: Print loan reminders (due within 30 days)

DECLARE
  v_count NUMBER := 0;
BEGIN
  FOR loan_rec IN (
    SELECT CustomerID, EndDate
    FROM EX1_Loans
    WHERE EndDate BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    v_count := v_count + 1;
    DBMS_OUTPUT.PUT_LINE(
      'Reminder: Loan due on ' || TO_CHAR(loan_rec.EndDate, 'DD-Mon-YYYY') ||
      ' for Customer ID: ' || loan_rec.CustomerID
    );
  END LOOP;

  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No loans due in the next 30 days.');
  END IF;
END;
/

-- 🔹 6. View Output

BEGIN
  FOR rec IN (
    SELECT CustomerID, Name, Balance, IsVIP FROM EX1_Customers
  ) LOOP
    DBMS_OUTPUT.PUT_LINE(
      'Customer ID: ' || rec.CustomerID ||
      ', Name: ' || rec.Name ||
      ', Balance: ' || rec.Balance ||
      ', VIP: ' || rec.IsVIP
    );
  END LOOP;
END;
/

BEGIN
  FOR rec IN (
    SELECT LoanID, CustomerID, InterestRate, EndDate FROM EX1_Loans
  ) LOOP
    DBMS_OUTPUT.PUT_LINE(
      'Loan ID: ' || rec.LoanID ||
      ', Customer ID: ' || rec.CustomerID ||
      ', Interest Rate: ' || rec.InterestRate ||
      ', End Date: ' || TO_CHAR(rec.EndDate, 'DD-Mon-YYYY')
    );
  END LOOP;
END;
/