# Bank Risk Data Platform

I am building a small data platform for a bank on Azure. It covers two things banks deal with every day: credit risk (which loans are likely to default) and anti-money laundering (which transactions look suspicious).

All data in this project is synthetic. I generate it myself with Python, so no real customer data is used anywhere.


## Status

- [x] Day 1: Synthetic bank data generated in Python and uploaded to Azure Data Lake Storage
- [x] Azure SQL Database with tables for customers, loans and transactions
- [ ] Git on my own computer for this repository
- [ ] Azure Data Factory pipeline that copies the files from the data lake into the database
- [ ] Data-quality checks in SQL
- [ ] Credit-risk model (probability of default) explained with SHAP
- [ ] Expected loss for each loan
- [ ] Anti-money-laundering rules in SQL, checked against the planted patterns
- [ ] Power BI report for credit risk and suspicious activity
- [ ] Notes and screenshots of the Azure part, since it runs on the Azure free credit

## Day 1 (28 October 2026)

I wrote a notebook that creates three tables for a bank: customers, loans and transactions. I made it bigger than my first try (20,000 customers instead of 5,000), so the credit-risk model will see enough defaults to learn from.

Loan amounts come from the customer's income. A mortgage is between two and five times the yearly income, never more, which follows the Norwegian lending rule. My first version picked loan amounts at random, and some people with low income ended up with huge mortgages, which no bank would give. I fixed that and checked that no mortgage is above five times income.

Defaults are not random. They depend on how much of the income goes to the monthly payment, the type of job, age and loan type, plus some noise, because in real life good customers sometimes default too. 732 of the 12,000 loans (6.1%) defaulted.

I also planted two money-laundering patterns in the transactions: structuring (40 customers making repeated cash deposits just under 10,000 euros in two weeks) and pass-through accounts (30 customers receiving large transfers and sending almost the same amount out within a day). I keep the answer key separate. It is never uploaded, so later I can measure how well my rules find these customers without cheating.

The random seed is fixed, so restarting and running the notebook gives exactly the same data. That is why the full data is not in this repository: the notebook is the source, and `data/sample` has the first 1,000 rows of each table so you can see what the data looks like.

On Azure I created a separate resource group for this project, a storage account with Data Lake Storage Gen2, and a `raw` container. I uploaded the three files there.

## Day 2 (29 October 2026)

I created an Azure SQL Database on the free offer, with overage billing disabled, so it pauses instead of charging when the monthly free limit is used up. It is in Sweden Central, because my free subscription had no SQL capacity in Norway East. Sign-in uses Microsoft Entra only, so there are no database passwords to store or leak.

I wrote the tables in T-SQL (`sql/01_create_tables.sql`). Each table has a primary key, and loans and transactions have foreign keys to customers, so the database itself rejects duplicate IDs and rows for customers that don't exist. The tables are empty for now. Azure Data Factory will fill them on Day 3.

## Data

| Table | Rows | What it holds |
|---|---|---|
| customers | 20,000 | age, yearly income in euros, employment type, region |
| loans | 12,000 | loan type, amount, interest rate, term, monthly payment, default flag |
| transactions | 801,528 | six months of card payments, transfers and cash deposits and withdrawals |

## Repository

- `01_generate_bank_data.ipynb`: creates the synthetic data
- `data/sample/`: the first 1,000 rows of each table
- `sql/`: SQL scripts for the Azure SQL Database
- `docs/azure/`: screenshots and notes of the Azure setup, day by day

## Tools so far

Python (pandas, NumPy), Jupyter, Azure Data Lake Storage Gen2, Azure SQL Database, T-SQL, GitHub
