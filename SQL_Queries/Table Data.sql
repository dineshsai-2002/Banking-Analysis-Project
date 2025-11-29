CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    dob DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    occupation VARCHAR(50),
    account_open_date date,
    account_type varchar(20),
    balance decimal(10,2),
    credit_score INT,
    loan_status varchar(20)
);
select * from customers;
alter table customers
add column full_name varchar(50)
after last_name;

alter table customers
add column age int after dob;
alter table customers
add income decimal(12,2) after occupation;
alter table customers
add column account_age int after account_open_date;
alter table customers
rename column Full_name to full_name;
alter table customers
modify column income decimal(12,2)
after loan_status;

CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    loan_type varchar(20),
    loan_amount decimal(15,3),
    interest_rate DECIMAL(5,2),
    tenure_months int,
    start_date date,
	end_date date,
    status varchar(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);



CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATETIME,
    transaction_type VARCHAR(50),
    amount DECIMAL(15,2),
    transaction_mode VARCHAR(30),
    merchant VARCHAR(100),
    status_transaction VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
select * from transactions;
ALTER TABLE TrANSACTIONS
ADD COLUMN year int after transaction_date;
ALTER TABLE TrANSACTIONS
ADD COLUMN month int after year;
ALTER TABLE TrANSACTIONS
ADD COLUMN day_of_week varchar(20) after month;
ALTER TABLE TrANSACTIONS
ADD COLUMN hour int After day_of_week ;
ALTER TABLE TrANSACTIONS
ADD COLUMN transaction_category int After transaction_type ;
ALTER TABLE TrANSACTIONS
ADD COLUMN merchant int After transaction_mode  ;
alter table transactions
modify transaction_mode varchar(30) after transaction_category;
alter table transactions
modify column transaction_category varchar(30) ;
alter table transactions
modify merchant varchar(25) after transaction_mode; 
alter table transactions
modify month varchar(15);
truncate table transactions;
select * from loans;
truncate table loans;
SET GLOBAL LOCAL_INFILE=ON;
alter table transactions
drop primary key;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions_d.csv" INTO TABLE TRANSACTIONS
FIELDS TERMINATED BY ','
IGNORE 1 LINES;
SHOW VARIABLES LIKE "secure_file_priv";
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/updated_loans_2000.csv" INTO TABLE loans
FIELDS TERMINATED BY ','
IGNORE 1 LINES;