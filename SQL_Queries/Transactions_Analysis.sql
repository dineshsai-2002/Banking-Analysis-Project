-- Based on Transaction Dataset Analysis :

-- 1.Calculate the total and average transaction amount per customer within the given time frame.
DELIMITER $$
CREATE PROCEDURE total_avg_transaction_per_customer(
    IN months_interval INT,
    OUT overall_avg DECIMAL(10,2)
)
BEGIN
    -- Show each customer's total and average transaction amounts within the given time frame
    SELECT 
        c.customer_id,
        c.full_name,
        ROUND(SUM(t.amount), 2) AS total_transaction_amount,
        ROUND(AVG(t.amount), 2) AS average_transaction_amount,
        COUNT(t.transaction_id) AS total_transactions
    FROM transactions t
    JOIN customers c ON c.customer_id = t.customer_id
    WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL months_interval MONTH)
    GROUP BY c.customer_id, c.full_name
    ORDER BY total_transaction_amount DESC;
-- Compute overall average transaction amount for the same period
    SELECT ROUND(AVG(t.amount), 2)
    INTO overall_avg
    FROM transactions t
    WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL months_interval MONTH);
END$$
DELIMITER ;

SET @overall_avg = 0;
CALL total_avg_transaction_per_customer(1, @overall_avg);
SELECT @overall_avg AS overall_average_transaction_amount;


-- 2.Find the top 10 customers who made the highest number of transactions in the last 6 months.
DELIMITER $$
CREATE PROCEDURE top_10_customers_last6months()
BEGIN
    SELECT 
        c.customer_id,
        c.full_name,
        COUNT(t.transaction_id) AS transaction_count,
        ROUND(SUM(t.amount), 2) AS total_transaction_amount
    FROM transactions t
    JOIN customers c ON c.customer_id = t.customer_id
    WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY c.customer_id, c.full_name
    ORDER BY transaction_count DESC, total_transaction_amount DESC
    LIMIT 10;
END$$
DELIMITER ;
CALL top_10_customers_last6months();


-- 3.Identify which transaction type (Deposit, Withdrawal, Transfer, etc.) is the most frequent.
DELIMITER $$
CREATE PROCEDURE most_frequent_transaction_type()
BEGIN
    SELECT 
        transaction_type,
        COUNT(transaction_id) AS total_transactions
    FROM transactions
    GROUP BY transaction_type
    ORDER BY total_transactions DESC
    LIMIT 1;
END$$
DELIMITER ;
CALL most_frequent_transaction_type();




-- 4.Display the monthly transaction trends — total transaction amount per month.
DELIMITER $$
CREATE PROCEDURE monthly_transaction_trends()
BEGIN
    SELECT 
        DATE_FORMAT(transaction_date, '%Y-%m') AS month,
        ROUND(SUM(amount), 2) AS total_transaction_amount,
        COUNT(transaction_id) AS total_transactions
    FROM transactions
    GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
    ORDER BY month ASC;
END$$
DELIMITER ;
CALL monthly_transaction_trends();
-- 5.List all high-value transactions above ₹50,000 and the customers who performed them.
DELIMITER $$
CREATE PROCEDURE high_value_transactions()
BEGIN
    SELECT 
        t.transaction_id,
        c.customer_id,
        c.full_name,
        c.city,
        t.transaction_type,
        t.amount,
        t.transaction_date
    FROM transactions t
    JOIN customers c ON c.customer_id = t.customer_id
    WHERE t.amount > 50000                                                                                                                                                                 
    ORDER BY t.amount DESC;
END$$
DELIMITER ;
drop procedure high_value_transactions;
CALL high_value_transactions();

------------------------------------------------------------------------------------------------------------------------------------

------------------------------------
-- INSIGHTS FROM TRANSACTIONS TABLE:
------------------------------------

-- the total and average transaction amount per customer FROM Last 3 months.
  SELECT 
        c.customer_id,
        c.full_name,
        ROUND(SUM(t.amount), 2) AS total_transaction_amount,
        ROUND(AVG(t.amount), 2) AS average_transaction_amount,
        COUNT(t.transaction_id) AS total_transactions
    FROM transactions t
    JOIN customers c ON c.customer_id = t.customer_id
	WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    GROUP BY c.customer_id, c.full_name
    ORDER BY total_transaction_amount DESC;


-- high-value transactions above ₹50,000 and the customers who performed them
 SELECT 
        t.transaction_id,c.customer_id,c.full_name,
        c.city,t.transaction_type,
        t.amount,t.transaction_date
    FROM transactions t
    JOIN customers c ON c.customer_id = t.customer_id
    WHERE t.amount > 50000                                                                                                                                                                 
    ORDER BY t.amount DESC;
    
-- Transaction_type wise total_amount
     
SELECT transaction_type,SUM(amount) AS total_amount
FROM transactions GROUP BY transaction_type
ORDER BY sum(amount) DESC;

-- monthly transaction trends — total transaction amount per month.
 SELECT 
        DATE_FORMAT(transaction_date, '%Y-%m') AS month,
        ROUND(SUM(amount), 2) AS total_transaction_amount,
        COUNT(transaction_id) AS total_transactions
    FROM transactions
    GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
    ORDER BY month ASC;

-- Which transaction type (Deposit, Withdrawal, Transfer, etc.) is the most frequent.
SELECT 
        transaction_type,
        COUNT(transaction_id) AS total_transactions
    FROM transactions
    GROUP BY transaction_type
    ORDER BY total_transactions DESC;


-- the top 10 customers who made the highest number of transactions in the last 6 months.
 SELECT 
        c.customer_id,
        c.full_name,
        COUNT(t.transaction_id) AS transaction_count,
        ROUND(SUM(t.amount), 2) AS total_transaction_amount
    FROM transactions t
    JOIN customers c ON c.customer_id = t.customer_id
    WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY c.customer_id, c.full_name
    ORDER BY transaction_count DESC, total_transaction_amount DESC
    LIMIT 10;
