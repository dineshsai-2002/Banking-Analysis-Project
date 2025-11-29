-- Based on Loan Dataset Analysis :

''' 1.Write a stored procedure named count_loans_by_status that takes a loan 
type as an input parameter and returns the number of loans grouped by their
status for that loan type, along with the total number of such loans as an output parameter.'''

DELIMITER $$
CREATE PROCEDURE count_loans_by_status(
    IN loan_type_filter VARCHAR(50),
    OUT total_loans_count INT
)
BEGIN
    SELECT 
        status AS loan_status,
        COUNT(loan_id) AS total_loans
    FROM loans
    WHERE loan_type = loan_type_filter
    GROUP BY status
    ORDER BY total_loans DESC;

    -- Get total number of loans for the given loan type
    SELECT COUNT(loan_id)
    INTO total_loans_count
    FROM loans
    WHERE loan_type = loan_type_filter;
END$$
DELIMITER ;

SET @total = 0;
CALL count_loans_by_status('education', @total);
SELECT @total AS total_home_loans;



-- 2.Calculate the total loan amount disbursed for each loan type (Home, Car, Education, etc.).
DELIMITER $$
CREATE PROCEDURE total_loan_amount_by_type()
BEGIN
    SELECT 
        loan_type,
        ROUND(SUM(loan_amount), 2) AS total_disbursed_amount,
        COUNT(loan_id) AS total_loans
    FROM loans
    GROUP BY loan_type
    ORDER BY total_disbursed_amount DESC;
END$$
DELIMITER ;
CALL total_loan_amount_by_type();

-- 3.Find the average interest rate for each loan type.
DELIMITER $$
CREATE PROCEDURE avg_interest_rate_by_type()
BEGIN
    SELECT 
        loan_type,
        ROUND(AVG(interest_rate), 2) AS avg_interest_rate
    FROM loans
    GROUP BY loan_type
    ORDER BY avg_interest_rate DESC;
END$$
DELIMITER ;
CALL avg_interest_rate_by_type();

-- 4.Identify customers who have taken more than one loan.
DELIMITER $$
CREATE PROCEDURE customers_with_multiple_loans()
BEGIN
    SELECT 
        c.customer_id,
        c.full_name,
        COUNT(l.loan_id) AS total_loans,
        ROUND(SUM(l.loan_amount), 2) AS total_loan_amount
    FROM loans l
    JOIN customers c ON c.customer_id = l.customer_id
    GROUP BY c.customer_id, c.full_name
    HAVING COUNT(l.loan_id) > 1
    ORDER BY total_loans DESC;
END$$
DELIMITER ;
CALL customers_with_multiple_loans();

-- 5.Calculate the percentage of loans fully repaid vs. defaulted to understand loan performance.
DELIMITER $$
CREATE PROCEDURE loan_performance_summary()
BEGIN
    SELECT 
        status,
        COUNT(loan_id) AS total_loans,
        ROUND((COUNT(loan_id) * 100 / (SELECT COUNT(*) FROM loans)), 2) AS percentage
    FROM loans
    WHERE status IN ('Closed', 'Defaulted')
    GROUP BY status;
END$$
DELIMITER ;
DROP PROCEDURE loan_performance_summary;
CALL loan_performance_summary();

------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------
-- INSIGHTS FROM LOANS TABLE:
-----------------------------------

-- loan_status and their counts
 SELECT 
        status AS loan_status,
        COUNT(loan_id) AS total_loans
    FROM loans
    GROUP BY status
    ORDER BY total_loans DESC;

-- Calculating the percentages of loans 
 SELECT 
        status,
        COUNT(loan_id) AS total_loans,
        ROUND((COUNT(loan_id) * 100 / (SELECT COUNT(*) FROM loans)), 2) AS percentage
    FROM loans
    GROUP BY status
    ORDER BY Total_loans desc;
    
    
    
-- customers who have taken more than one loan.    
SELECT 
        c.customer_id,
        c.full_name,
        COUNT(l.loan_id) AS total_loans,
        ROUND(SUM(l.loan_amount), 2) AS total_loan_amount
    FROM loans l
    JOIN customers c ON c.customer_id = l.customer_id
    GROUP BY c.customer_id, c.full_name
    HAVING COUNT(l.loan_id) > 1
    ORDER BY total_loans DESC;


-- the total loan amount disbursed for each loan type and their count
 SELECT 
        loan_type,
        ROUND(SUM(loan_amount), 2) AS total_disbursed_amount,
        COUNT(loan_id) AS total_loans
    FROM loans
    GROUP BY loan_type
    ORDER BY total_loans DESC;

-- Avg interest rate for each loan
 SELECT 
        loan_type,
        ROUND(AVG(interest_rate), 2) AS avg_interest_rate
    FROM loans
    GROUP BY loan_type
    ORDER BY avg_interest_rate DESC;





