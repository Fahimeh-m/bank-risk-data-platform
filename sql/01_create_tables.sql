CREATE TABLE dbo.customers (
    customer_id        INT            NOT NULL PRIMARY KEY,
    age                INT            NOT NULL,
    annual_income_eur  DECIMAL(12,2)  NOT NULL,
    employment_type    VARCHAR(20)    NOT NULL,
    region             VARCHAR(20)    NOT NULL
);

CREATE TABLE dbo.loans (
    loan_id              INT            NOT NULL PRIMARY KEY,
    customer_id          INT            NOT NULL REFERENCES dbo.customers(customer_id),
    loan_type            VARCHAR(20)    NOT NULL,
    amount_eur           DECIMAL(12,2)  NOT NULL,
    interest_rate        DECIMAL(6,4)   NOT NULL,
    term_months          INT            NOT NULL,
    monthly_payment_eur  DECIMAL(12,2)  NOT NULL,
    defaulted            BIT            NOT NULL
);

CREATE TABLE dbo.transactions (
    transaction_id    INT            NOT NULL PRIMARY KEY,
    customer_id       INT            NOT NULL REFERENCES dbo.customers(customer_id),
    [timestamp]       DATETIME2(0)   NOT NULL,
    transaction_type  VARCHAR(20)    NOT NULL,
    amount_eur        DECIMAL(12,2)  NOT NULL
);
