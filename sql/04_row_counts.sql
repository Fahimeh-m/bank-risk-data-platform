SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM dbo.customers
UNION ALL
SELECT 'loans', COUNT(*) FROM dbo.loans
UNION ALL
SELECT 'transactions', COUNT(*) FROM dbo.transactions;