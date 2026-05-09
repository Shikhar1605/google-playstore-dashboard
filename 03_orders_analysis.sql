-- =========================================
-- VIEW FIRST 10 ROWS FROM ORDERS TABLE
-- =========================================

SELECT * FROM orders LIMIT 10;

-- =========================================
-- COUNT TOTAL ORDERS
-- =========================================

SELECT COUNT(*) AS total_orders FROM orders;

-- =========================================
-- FIND UNIQUE ORDER STATUSES
-- =========================================

SELECT DISTINCT order_status FROM orders ORDER BY order_status;

-- =========================================
-- COUNT ORDERS BY STATUS
-- =========================================

SELECT order_status,COUNT(*) AS total_orders FROM orders GROUP BY 
order_status ORDER BY total_orders DESC; 

-- =========================================
-- COUNT DELIVERED ORDERS
-- =========================================

SELECT COUNT(*) AS total_delivered_orders FROM orders 
WHERE order_status='delivered';

-- =========================================
-- COUNT CANCELED ORDERS
-- =========================================

SELECT COUNT(*) AS total_canceled_orders FROM orders
WHERE order_status='canceled';

-- =========================================
-- FIND LATEST 10 ORDERS
-- =========================================

SELECT order_id,order_purchase_timestamp FROM orders 
ORDER BY order_purchase_timestamp DESC LIMIT 10;

-- =========================================
-- FIND EARLIEST 10 ORDERS
-- =========================================

SELECT order_id,order_purchase_timestamp FROM orders 
ORDER BY order_purchase_timestamp LIMIT 10;

-- =========================================
-- COUNT ORDERS MONTH-WISE
-- =========================================

SELECT EXTRACT(MONTH FROM order_purchase_timestamp::TIMESTAMP) AS order_month,
COUNT(*) AS month_wise_count FROM orders GROUP BY order_month 
ORDER BY order_month;

-- =========================================
-- FIND MONTH WITH HIGHEST NUMBER OF ORDERS
-- =========================================

SELECT EXTRACT(MONTH FROM order_purchase_timestamp::TIMESTAMP) AS order_month,
COUNT(*) AS month_wise_count FROM orders GROUP BY order_month
ORDER BY month_wise_count DESC LIMIT 1;

-- =========================================
-- FIND TOP 3 MONTHS WITH HIGHEST ORDERS
-- =========================================

SELECT EXTRACT(MONTH FROM order_purchase_timestamp::TIMESTAMP) AS order_month,
COUNT(*) AS month_wise_count FROM orders GROUP BY order_month 
ORDER BY month_wise_count DESC LIMIT 3;

-- =========================================
-- COUNT ORDERS YEAR-WISE
-- =========================================

SELECT EXTRACT(YEAR FROM order_purchase_timestamp::TIMESTAMP) AS order_year,
COUNT(*) AS year_wise_count FROM orders GROUP BY order_year ORDER BY order_year;

-- =========================================
-- FIND YEAR WITH HIGHEST NUMBER OF ORDERS
-- =========================================

SELECT EXTRACT(YEAR FROM order_purchase_timestamp::TIMESTAMP) AS order_year,
COUNT(*) AS year_wise_count FROM orders GROUP BY order_year 
ORDER BY year_wise_count DESC LIMIT 1;

-- =========================================
-- COUNT ORDERS BY STATUS YEAR-WISE
-- =========================================

SELECT order_status,EXTRACT(YEAR FROM order_purchase_timestamp::TIMESTAMP) AS order_year,
COUNT(*) AS year_wise_count FROM orders GROUP BY order_status,order_year 
ORDER BY order_year,order_status;

-- =========================================
-- COUNT DELIVERED ORDERS YEAR-WISE
-- =========================================

SELECT order_status,EXTRACT(YEAR FROM order_purchase_timestamp::TIMESTAMP) AS order_year,
COUNT(*) AS year_wise_count FROM orders WHERE order_status='delivered' 
GROUP BY order_year,order_status ORDER BY order_year;