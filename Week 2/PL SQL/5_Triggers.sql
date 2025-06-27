-- 📌 Exercise 5: Triggers (Final Version)
-- Author: Bhavana

-- 🔹 1. Trigger: UpdateCustomerLastModified
CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON EX1_Customers
FOR EACH ROW
BEGIN
  :NEW.LastModified := SYSDATE;
END;
/

-- 🔹 2. Audit Log Table
CREATE TABLE EX1_TransactionAuditLog (
  AuditID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  TransactionID NUMBER,
  AccountID NUMBER,
  Action VARCHAR2(20),
  ActionDate DATE
);

-- 🔹 3. Trigger: LogTransaction
CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON EX1_Transactions
FOR EACH ROW
BEGIN
  INSERT INTO EX1_TransactionAuditLog (
    TransactionID, AccountID, Action, ActionDate
  ) VALUES (
    :NEW.TransactionID, :NEW.AccountID, 'INSERT', SYSDATE
  );
END;
/

-- 🔹 4. Trigger: CheckTransactionRules
CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON EX1_Transactions
FOR EACH ROW
DECLARE
  v_balance NUMBER;
BEGIN
  SELECT Balance INTO v_balance FROM EX1_Accounts WHERE AccountID = :NEW.AccountID;

  IF :NEW.TransactionType = 'Withdrawal' THEN
    IF :NEW.Amount > v_balance THEN
      RAISE_APPLICATION_ERROR(-20020, 'Withdrawal exceeds account balance.');
    END IF;
  ELSIF :NEW.TransactionType = 'Deposit' THEN
    IF :NEW.Amount <= 0 THEN
      RAISE_APPLICATION_ERROR(-20021, 'Deposit amount must be positive.');
    END IF;
  END IF;
END;
/

-- 🧪 5. Test Triggers

-- ✅ Trigger 1 Test: Update customer
UPDATE EX1_Customers
SET Name = 'John Updated'
WHERE CustomerID = 1;

-- ✅ Trigger 2 + 3 Test: Insert valid transactions
INSERT INTO EX1_Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (10, 1, SYSDATE, 500, 'Deposit');

INSERT INTO EX1_Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (11, 1, SYSDATE, 200, 'Withdrawal');

-- ❌ Uncomment to test business rule violation (Trigger 3 error):
-- INSERT INTO EX1_Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
-- VALUES (12, 1, SYSDATE, -500, 'Deposit'); -- Invalid: Negative deposit

-- INSERT INTO EX1_Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
-- VALUES (13, 1, SYSDATE, 9999999, 'Withdrawal'); -- Invalid: Exceeds balance

COMMIT;

-- 🔍 6. View Results for Verification

-- ✅ Check if LastModified updated
SELECT CustomerID, Name, LastModified FROM EX1_Customers;

-- ✅ Check audit log trigger worked
SELECT * FROM EX1_TransactionAuditLog;

-- ✅ Check transactions inserted
SELECT * FROM EX1_Transactions ORDER BY TransactionID DESC;
