-- =========================================
-- FIND AVERAGE ORDERS PER STATE USING CTE
-- =========================================

WITH state_order_counts AS (SELECT c.customer_state,COUNT(*) AS state_orders
FROM customer AS c INNER JOIN orders AS o ON c.customer_id=o.customer_id 
GROUP BY c.customer_state) 
SELECT AVG(state_orders) AS average_orders FROM state_order_counts;

-- =========================================
-- RANK STATES BASED ON TOTAL ORDERS
-- =========================================

WITH state_order_counts AS (SELECT c.customer_state,COUNT(*) AS state_orders
FROM customer AS c INNER JOIN orders AS o ON c.customer_id=o.customer_id
GROUP BY c.customer_state) SELECT customer_state,state_orders, 
ROW_NUMBER() OVER(ORDER BY state_orders) AS state_rank FROM state_order_counts;

-- =========================================
-- RANK CITIES BASED ON DELIVERED ORDERS
-- =========================================

WITH delivered_orders AS (SELECT c.customer_city,COUNT(*) AS city_orders
FROM customer AS c INNER JOIN orders AS o ON c.customer_id=o.customer_id
WHERE order_status='delivered' GROUP BY c.customer_city) SELECT customer_city,city_orders,
RANK() OVER (ORDER BY city_orders DESC) AS city_rank FROM delivered_orders;

-- =========================================
-- FIND TOP CITIES BY DELIVERED ORDERS WITHIN EACH STATE
-- =========================================

WITH delivered_orders AS (SELECT c.customer_state,c.customer_city,COUNT(*) AS city_orders
FROM customer AS c INNER JOIN orders AS o ON c.customer_id=o.customer_id
WHERE order_status='delivered' GROUP BY c.customer_state,c.customer_city) 
SELECT customer_city,customer_state,city_orders,
RANK() OVER(PARTITION BY customer_state ORDER BY city_orders DESC) AS city_rank
FROM delivered_orders;

-- =========================================
-- DENSE RANK CITIES BY DELIVERED ORDERS WITHIN EACH STATE
-- =========================================

WITH delivered_orders AS (SELECT c.customer_state,c.customer_city,COUNT(*) AS city_orders
FROM customer AS c INNER JOIN orders AS O ON c.customer_id=o.customer_id
WHERE order_status='delivered' GROUP BY c.customer_state,c.customer_city)
SELECT customer_city,customer_state,city_orders,
DENSE_RANK() OVER(PARTITION BY customer_state ORDER BY city_orders DESC)AS city_rank
FROM delivered_orders;

-- =========================================
-- FIND TOP 3 DELIVERY CITIES WITHIN EACH STATE
-- =========================================

WITH delivered_orders AS (SELECT c.customer_state,c.customer_city,COUNT(*) AS city_orders
FROM customer AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered' GROUP BY c.customer_state,c.customer_city),
ranked_cities AS (SELECT customer_city,customer_state,city_orders,
DENSE_RANK() OVER(PARTITION BY customer_state ORDER BY city_orders DESC)AS city_rank
FROM delivered_orders)SELECT * FROM ranked_cities WHERE city_rank <= 3;

-- =========================================
-- CALCULATE CUMULATIVE MONTHLY DELIVERED ORDERS
-- =========================================

WITH monthly_delivered_orders AS(SELECT EXTRACT(MONTH FROM o.order_purchase_timestamp
::TIMESTAMP) AS order_month,COUNT(*) AS delivered_orders
FROM orders AS o WHERE o.order_status = 'delivered'GROUP BY order_month)
SELECT order_month,delivered_orders,SUM(delivered_orders) 
OVER(ORDER BY order_month) AS cumulative_delivered_orders FROM monthly_delivered_orders;

-- =========================================
-- COMPARE MONTHLY DELIVERED ORDERS WITH PREVIOUS MONTH
-- =========================================

WITH monthly_delivered_orders AS (SELECT EXTRACT(MONTH FROM o.order_purchase_timestamp
::TIMESTAMP) AS order_month,COUNT(*) AS delivered_orders FROM orders AS o
WHERE o.order_status = 'delivered' GROUP BY order_month)
SELECT order_month,delivered_orders,LAG(delivered_orders) OVER(
ORDER BY order_month) AS previous_month_orders FROM monthly_delivered_orders;

-- =========================================
-- CALCULATE MONTH-OVER-MONTH DELIVERY GROWTH
-- =========================================

WITH monthly_delivered_orders AS (SELECT EXTRACT(MONTH FROM o.order_purchase_timestamp
::TIMESTAMP) AS order_month,COUNT(*) AS delivered_orders FROM orders AS o 
WHERE o.order_status = 'delivered' GROUP BY order_month)
SELECT order_month,delivered_orders,LAG(delivered_orders) OVER(
ORDER BY order_month) AS previous_month_orders,delivered_orders - LAG(delivered_orders) 
OVER(ORDER BY order_month)AS monthly_growth FROM monthly_delivered_orders;