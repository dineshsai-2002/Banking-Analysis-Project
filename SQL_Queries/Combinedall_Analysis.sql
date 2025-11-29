-- 1. Find each customer’s total transaction amount and total loan amount, and 
--  identify the top n customers by overall banking activity.
DELIMITER $$
CREATE PROCEDURE topn_customers_activity(IN top_n int)
BEGIN
    SELECT 
        c.customer_id,
        c.full_name,
        COALESCE(SUM(t.amount), 0) AS total_transaction_amount,
        COALESCE(SUM(l.loan_amount), 0) AS total_loan_amount,
        (COALESCE(SUM(t.amount), 0) + COALESCE(SUM(l.loan_amount), 0)) AS overall_value
    FROM customers c
    LEFT JOIN transactions t ON c.customer_id = t.customer_id
    LEFT JOIN loans l ON c.customer_id = l.customer_id
    GROUP BY c.customer_id, c.full_name
    ORDER BY overall_value DESC
    LIMIT top_n;
END$$
DELIMITER ;
CALL topn_customers_activity(10);


-- 2.List customers who have active loans and also made transactions in the last 6 months.
DELIMITER $$
CREATE PROCEDURE active_loan_recent_transactions(
	IN p_Status varchar(50), 
    OUT active_count INT
)
BEGIN
    SELECT 
        DISTINCT c.customer_id,
        c.full_name,
        l.loan_id,
        l.status AS loan_status,
        MAX(t.transaction_date) AS last_transaction_date
    FROM customers c
    JOIN loans l ON c.customer_id = l.customer_id
    JOIN transactions t ON c.customer_id = t.customer_id
    WHERE l.status = p_status
      AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY c.customer_id, l.loan_id;
    SELECT COUNT(DISTINCT c.customer_id)
    INTO active_count
    FROM customers c
    JOIN loans l ON c.customer_id = l.customer_id
    JOIN transactions t ON c.customer_id = t.customer_id
    WHERE l.status = p_status
      AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
END$$
DELIMITER ;
drop procedure active_loan_recent_transactions;
CALL active_loan_recent_transactions('default',@count); -- status:active,closed,approved,charged off,default,defaulted,pending
SELECT @count as total_active_customers;


-- 3. Compare the average income of customers who have taken a loan vs. those who have not.
DELIMITER $$
CREATE PROCEDURE avg_income_vs_loan_status()
BEGIN
    SELECT 
        CASE 
            WHEN loan_count > 0 THEN 'Has Loan' 
            ELSE 'No Loan' 
        END AS loan_status,
        ROUND(AVG(income), 2) AS avg_income
    FROM (
        SELECT 
            c.income,
            COUNT(l.customer_id) AS loan_count
        FROM customers c
        LEFT JOIN loans l ON c.customer_id = l.customer_id
        GROUP BY c.customer_id, c.income
    ) AS customer_summary
    GROUP BY LOAN_STATUS;
END$$
DELIMITER ;
DROP PROCEDURE avg_income_vs_loan_status;
CALL avg_income_vs_loan_status();

-- 4. Find the top 5 cities where the total loan disbursed amount and transaction value are both highest.
DELIMITER $$
CREATE PROCEDURE top_cities_by_financial_activity()
BEGIN
    SELECT 
        c.city,
        COALESCE(SUM(t.amount), 0) AS total_transaction_amount,
        COALESCE(SUM(l.loan_amount), 0) AS total_loan_amount,
        (COALESCE(SUM(t.amount), 0) + COALESCE(SUM(l.loan_amount), 0)) AS combined_total
    FROM customers c
    LEFT JOIN transactions t ON c.customer_id = t.customer_id
    LEFT JOIN loans l ON c.customer_id = l.customer_id
    GROUP BY c.city
    ORDER BY combined_total DESC
    LIMIT 5;
END$$
DELIMITER ;
CALL top_cities_by_financial_activity();

-- 5.Identify customers who have taken loans but made no transactions in the
--  last userenterd months (possible inactive or at-risk customers).
DELIMITER $$
CREATE PROCEDURE inactive_loan_customers(IN Months_interval Int)
BEGIN
    SELECT 
        c.customer_id,
        c.full_name,
        l.loan_id,
        l.status AS loan_status
    FROM customers c
    JOIN loans l ON c.customer_id = l.customer_id
    LEFT JOIN transactions t 
           ON c.customer_id = t.customer_id 
           AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL Months_interval MONTH)
    WHERE t.transaction_id IS NULL;
END$$
DELIMITER ;
CALL inactive_loan_customers(2);

------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------
-- OVERALL INSIGHTS :
-----------------------------------


-- the top 10 customers by overall banking activity.
SELECT 
        c.customer_id,
        c.full_name,
        SUM(t.amount) AS total_transaction_amount,
        SUM(l.loan_amount) AS total_loan_amount,
        SUM(t.amount) + SUM(l.loan_amount) AS overall_value
    FROM customers c
    LEFT JOIN transactions t ON c.customer_id = t.customer_id
    LEFT JOIN loans l ON c.customer_id = l.customer_id
    GROUP BY c.customer_id, c.full_name
    ORDER BY overall_value DESC
    LIMIT 10;

-- customers Loan_Status and also made transactions in the last 6 months.
  SELECT 
        DISTINCT c.customer_id,
        c.full_name,
        l.loan_id,
        l.status AS loan_status,
        MAX(t.transaction_date) AS last_transaction_date
    FROM customers c
    JOIN loans l ON c.customer_id = l.customer_id
    JOIN transactions t ON c.customer_id = t.customer_id
      AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY c.customer_id, l.loan_id;
    
    
-- customers who have taken loans but not made transactions in the last 6 months
  SELECT 
        c.customer_id,
        c.full_name,
        l.loan_id,
        l.status AS loan_status
    FROM customers c
    JOIN loans l ON c.customer_id = l.customer_id
    LEFT JOIN transactions t 
           ON c.customer_id = t.customer_id 
           AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    WHERE t.transaction_id IS NULL;


-- the top 5 cities where the total loan disbursed amount and transaction value are both highest.
 SELECT 
        c.city,
        SUM(t.amount) AS total_transaction_amount,
        SUM(l.loan_amount) AS total_loan_amount,
        SUM(t.amount)+ SUM(l.loan_amount) AS combined_total
    FROM customers c
    LEFT JOIN transactions t ON c.customer_id = t.customer_id
    LEFT JOIN loans l ON c.customer_id = l.customer_id
    GROUP BY c.city
    ORDER BY combined_total DESC
    LIMIT 5;
    
    
-- the average income of customers who have taken a loan vs. those who have not.    
SELECT 
        CASE 
            WHEN loan_count > 0 THEN 'Has Loan' 
            ELSE 'No Loan' 
        END AS loan_status,
        ROUND(AVG(income), 2) AS avg_income
    FROM (
        SELECT 
            c.income,
            COUNT(l.customer_id) AS loan_count
        FROM customers c
        LEFT JOIN loans l ON c.customer_id = l.customer_id
        GROUP BY c.customer_id, c.income
    ) AS customer_summary
    GROUP BY LOAN_STATUS;