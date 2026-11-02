-- Data-quality checks for the bank database
-- Results from the run on 2 November 2026

-- 1. Number of defaults
-- Result: 11268 not defaulted, 732 defaulted
SELECT defaulted, COUNT(*) AS loan_count
FROM dbo.loans
GROUP BY defaulted
ORDER BY defaulted;

-- 2. Loans with invalid values
-- Result: 0
SELECT COUNT(*) AS bad_loans
FROM dbo.loans
WHERE amount_eur <= 0
   OR interest_rate <= 0
   OR interest_rate >= 1
   OR term_months <= 0
   OR monthly_payment_eur <= 0;

-- 3. Customers with invalid values
-- Result: 0
SELECT COUNT(*) AS bad_customers
FROM dbo.customers
WHERE age < 18
   OR age > 100
   OR annual_income_eur <= 0;

-- 4. Transaction amount and date ranges
-- Result: 0.19 to 49754.48 EUR, from 2026-04-01 to 2026-09-30
SELECT
    MIN(amount_eur) AS min_amount,
    MAX(amount_eur) AS max_amount,
    MIN([timestamp]) AS first_date,
    MAX([timestamp]) AS last_date
FROM dbo.transactions;

-- 5. Loans and transactions without a customer
-- Result: 0 and 0
SELECT
    (SELECT COUNT(*)
     FROM dbo.loans AS l
     LEFT JOIN dbo.customers AS c ON l.customer_id = c.customer_id
     WHERE c.customer_id IS NULL) AS orphan_loans,
    (SELECT COUNT(*)
     FROM dbo.transactions AS t
     LEFT JOIN dbo.customers AS c ON t.customer_id = c.customer_id
     WHERE c.customer_id IS NULL) AS orphan_transactions;
