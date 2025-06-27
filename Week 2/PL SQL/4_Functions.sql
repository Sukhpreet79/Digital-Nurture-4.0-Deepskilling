-- 📌 Exercise 4: Functions – Age, EMI, Balance Check
-- Author: Bhavana

-- 🔹 Function 1: CalculateAge
-- Returns age in years based on DOB

CREATE OR REPLACE FUNCTION CalculateAge(p_dob DATE)
RETURN NUMBER
IS
  v_age NUMBER;
BEGIN
  v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
  RETURN v_age;
END;
/

-- 🔹 Function 2: CalculateMonthlyInstallment
-- Returns EMI using formula: EMI = (P * r * (1 + r)^n) / ((1 + r)^n - 1)

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
  p_loan_amount     NUMBER,
  p_annual_rate     NUMBER,
  p_duration_years  NUMBER
)
RETURN NUMBER
IS
  v_monthly_rate NUMBER;
  v_months       NUMBER;
  v_emi          NUMBER;
BEGIN
  v_monthly_rate := p_annual_rate / (12 * 100); -- Convert annual % to monthly decimal
  v_months := p_duration_years * 12;

  v_emi := (p_loan_amount * v_monthly_rate * POWER(1 + v_monthly_rate, v_months)) /
           (POWER(1 + v_monthly_rate, v_months) - 1);

  RETURN ROUND(v_emi, 2);
END;
/

-- 🔹 Function 3: HasSufficientBalance
-- Returns 1 if account has enough balance, 0 otherwise

CREATE OR REPLACE FUNCTION HasSufficientBalance(
  p_account_id NUMBER,
  p_amount     NUMBER
)
RETURN BOOLEAN
IS
  v_balance NUMBER;
BEGIN
  SELECT Balance INTO v_balance FROM EX1_Accounts WHERE AccountID = p_account_id;

  IF v_balance >= p_amount THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
  WHEN OTHERS THEN
    RETURN FALSE;
END;
/

-- 🧪 Test All Functions (results in DBMS Output)

DECLARE
  v_age NUMBER;
  v_emi NUMBER;
  v_check BOOLEAN;
BEGIN
  DBMS_OUTPUT.PUT_LINE('-- Testing CalculateAge --');
  v_age := CalculateAge(TO_DATE('2000-01-01', 'YYYY-MM-DD'));
  DBMS_OUTPUT.PUT_LINE('Age: ' || v_age);

  DBMS_OUTPUT.PUT_LINE('-- Testing CalculateMonthlyInstallment --');
  v_emi := CalculateMonthlyInstallment(100000, 10, 5);
  DBMS_OUTPUT.PUT_LINE('EMI: ' || v_emi);

  DBMS_OUTPUT.PUT_LINE('-- Testing HasSufficientBalance --');
  v_check := HasSufficientBalance(1, 500);
  IF v_check THEN
    DBMS_OUTPUT.PUT_LINE('Sufficient balance ');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Insufficient balance ');
  END IF;
END;
/
