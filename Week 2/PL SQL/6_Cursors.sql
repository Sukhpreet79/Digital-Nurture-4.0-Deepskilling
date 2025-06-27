-- 📌 Exercise 6: Cursors – Monthly Statements, Annual Fee, Interest Update
-- Author: Bhavana

-- 🔹 Scenario 1: GenerateMonthlyStatements
-- Retrieve all transactions for the current month and print per customer

DECLARE
  CURSOR cur_transactions IS
    SELECT c.CustomerID, c.Name, t.TransactionDate, t.Amount, t.TransactionType
    FROM EX1_Customers c
    JOIN EX1_Accounts a ON c.CustomerID = a.CustomerID
    JOIN EX1_Transactions t ON a.AccountID = t.AccountID
    WHERE EXTRACT(MONTH FROM t.TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
      AND EXTRACT(YEAR FROM t.TransactionDate) = EXTRACT(YEAR FROM SYSDATE)
    ORDER BY c.CustomerID;

  v_cust_id EX1_Customers.CustomerID%TYPE;
  v_name EX1_Customers.Name%TYPE;
  v_date EX1_Transactions.TransactionDate%TYPE;
  v_amt EX1_Transactions.Amount%TYPE;
  v_type EX1_Transactions.TransactionType%TYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('-- Monthly Statements for Current Month --');
  OPEN cur_transactions;
  LOOP
    FETCH cur_transactions INTO v_cust_id, v_name, v_date, v_amt, v_type;
    EXIT WHEN cur_transactions%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_cust_id || ', Name: ' || v_name ||
                         ', Date: ' || v_date || ', Type: ' || v_type ||
                         ', Amount: ' || v_amt);
  END LOOP;
  CLOSE cur_transactions;
END;
/

-- 🔹 Scenario 2: ApplyAnnualFee
-- Deduct ₹100 from all account balances

DECLARE
  CURSOR cur_accounts IS
    SELECT AccountID FROM EX1_Accounts;

  v_acc_id EX1_Accounts.AccountID%TYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('-- Applying Annual Maintenance Fee --');
  OPEN cur_accounts;
  LOOP
    FETCH cur_accounts INTO v_acc_id;
    EXIT WHEN cur_accounts%NOTFOUND;

    UPDATE EX1_Accounts
    SET Balance = Balance - 100
    WHERE AccountID = v_acc_id;

    DBMS_OUTPUT.PUT_LINE('Annual fee deducted from Account ID: ' || v_acc_id);
  END LOOP;
  CLOSE cur_accounts;
  COMMIT;
END;
/

-- 🔹 Scenario 3: UpdateLoanInterestRates
-- Update all loan interest rates by adding 0.5% as per new policy

DECLARE
  CURSOR cur_loans IS
    SELECT LoanID, InterestRate FROM EX1_Loans;

  v_loan_id EX1_Loans.LoanID%TYPE;
  v_old_rate EX1_Loans.InterestRate%TYPE;
  v_new_rate EX1_Loans.InterestRate%TYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('-- Updating Loan Interest Rates --');
  OPEN cur_loans;
  LOOP
    FETCH cur_loans INTO v_loan_id, v_old_rate;
    EXIT WHEN cur_loans%NOTFOUND;

    v_new_rate := v_old_rate + 0.5;

    UPDATE EX1_Loans
    SET InterestRate = v_new_rate
    WHERE LoanID = v_loan_id;

    DBMS_OUTPUT.PUT_LINE('Loan ID: ' || v_loan_id || ', Old Rate: ' || v_old_rate ||
                         ', New Rate: ' || v_new_rate);
  END LOOP;
  CLOSE cur_loans;
  COMMIT;
END;
/
