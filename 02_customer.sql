-- =========================================
-- VIEW FIRST 10 ROWS
-- =========================================

SELECT * FROM customer LIMIT 10;

-- =========================================
-- COUNT TOTAL CUSTOMERS
-- =========================================

SELECT COUNT(*) AS total_customers FROM customer;

-- =========================================
-- FIND UNIQUE STATES
-- =========================================

SELECT DISTINCT customer_state FROM customer ORDER BY customer_state;

-- =========================================
-- COUNT TOTAL UNIQUE CUSTOMER STATES
-- =========================================

SELECT COUNT(DISTINCT customer_state) AS total_unique_states FROM customer;
