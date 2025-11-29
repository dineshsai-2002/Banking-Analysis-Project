-------------------------------------------------------------------------------
----------------- Based on Customer Dataset Analysis: -------------------------
--------------------------------------------------------------------------------

SELECT * from customers;
-- 1.Find the total number of customers by gender and account type.
DELIMITER $$

CREATE PROCEDURE total_customers_by_gender_account(
    IN acc_type VARCHAR(50),
    OUT total_count INT
)
BEGIN
    -- Display total customers by gender and account type (filtered if acc_type is given)
    SELECT 
        gender,
        account_type,
        COUNT(customer_id) AS total_customers
    FROM customers
    WHERE account_type = acc_type
    GROUP BY gender, account_type
    ORDER BY gender, total_customers DESC;
    -- Get total count of customers (filtered by account type if provided)
    SELECT COUNT(customer_id)
    INTO total_count
    FROM customers
    WHERE account_type = acc_type;
END$$
DELIMITER ;

SET @count = 0;
CALL total_customers_by_gender_account('Salary', @count);
SELECT @count AS total_savings_customers;


-- 2.List all customers whose income is greater than ₹1,00,000 .
DELIMITER $$
CREATE PROCEDURE high_income_customers(IN P_income int)
BEGIN
    SELECT 
        customer_id,
        full_name,
        gender,
        age,
        city,
        income
    FROM customers
    WHERE income > P_income
    ORDER BY income DESC limit 5;
END$$
DELIMITER ;
drop procedure high_income_customers;
CALL high_income_customers(100000);

-- 3.Classify customers into age groups (e.g., 18–25, 26–35, 36–45, etc.) and count customers in each group.
DELIMITER $$
CREATE PROCEDURE customers_by_age_group()
BEGIN
    SELECT 
        CASE
            WHEN age BETWEEN 18 AND 25 THEN '18–25'
            WHEN age BETWEEN 26 AND 35 THEN '26–35'
            WHEN age BETWEEN 36 AND 45 THEN '36–45'
            WHEN age BETWEEN 46 AND 60 THEN '46–60'
            ELSE '60+'
        END AS age_group,
        COUNT(customer_id) AS total_customers
    FROM customers
    GROUP BY age_group
    ORDER BY age_group;
END$$
DELIMITER ;
CALL customers_by_age_group();

-- 4.Identify the top 5 locations (cities or states) with the highest number of customers.
DELIMITER $$
CREATE PROCEDURE top_5_locations()
BEGIN
    SELECT 
        city,
        COUNT(customer_id) AS total_customers
    FROM customers
    GROUP BY city
    ORDER BY total_customers DESC
    LIMIT 5;
END$$
DELIMITER ;
drop procedure top_5_locations; 
CALL top_5_locations();

-- 5.Determine the most popular account type among all customers. 
DELIMITER $$
CREATE PROCEDURE most_popular_account_type()
BEGIN
    SELECT 
        account_type,
        COUNT(customer_id) AS total_customers
    FROM customers
    GROUP BY account_type
    ORDER BY total_customers DESC
    LIMIT 1;
END$$
DELIMITER ;
DROP PROCEDURE most_popular_account_type;
CALL most_popular_account_type();

------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------
-- INSIGHTS FROM CUSTOMERS TABLE:
-----------------------------------

-- gender wise and account_type wise customers count
SELECT 
        gender,
        account_type,
        COUNT(customer_id) AS total_customers
    FROM customers
    GROUP BY gender, account_type
    ORDER BY total_customers DESC;
    
-- most popular account_type and their customers count 
SELECT 
        account_type,
        COUNT(customer_id) AS total_customers
    FROM customers
    GROUP BY account_type
    ORDER BY total_customers DESC;
    
-- customers whose income is greater than ₹1,00,000 .    
SELECT 
        customer_id,
        full_name,
        gender,
        age,
        city,
        income
    FROM customers
    WHERE income > 100000
    ORDER BY income DESC limit 5;
    
--  the top 5 locations with the highest number of customers.    
SELECT 
        city,
        COUNT(customer_id) AS total_customers
    FROM customers
    GROUP BY city
    ORDER BY total_customers DESC
    LIMIT 5;
    

-- age groups (e.g., 18–25, 26–35, 36–45, etc.) and count customers in each group.
  SELECT 
        CASE
            WHEN age BETWEEN 18 AND 25 THEN '18–25'
            WHEN age BETWEEN 26 AND 35 THEN '26–35'
            WHEN age BETWEEN 36 AND 45 THEN '36–45'
            WHEN age BETWEEN 46 AND 60 THEN '46–60'
            ELSE '60+'
        END AS age_group,
        COUNT(customer_id) AS total_customers
    FROM customers
    GROUP BY age_group
    ORDER By total_customers desc ;