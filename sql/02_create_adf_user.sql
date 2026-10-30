CREATE USER [adf-bank-risk-fm] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [adf-bank-risk-fm];
ALTER ROLE db_datawriter ADD MEMBER [adf-bank-risk-fm];