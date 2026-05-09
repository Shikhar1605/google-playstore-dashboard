-- =========================================
-- DISPLAY CUSTOMER AND ORDER DETAILS
-- =========================================

SELECT customer.customer_id,customer.customer_city,orders.order_id,orders.order_status
FROM customer INNER JOIN orders ON customer.customer_id=orders.customer_id;

-- =========================================
-- COUNT TOTAL ORDERS BY STATE
-- =========================================

SELECT customer.customer_state,COUNT(*) AS orders_by_state FROM customer
INNER JOIN orders ON customer.customer_id=orders.customer_id 
GROUP BY customer.customer_state ORDER BY orders_by_state DESC;

-- =========================================
-- FIND TOP 10 CITIES WITH HIGHEST ORDERS
-- =========================================

SELECT customer.customer_city,COUNT(*) AS city_wise_orders FROM customer
INNER JOIN orders ON customer.customer_id=orders.customer_id 
GROUP BY customer.customer_city ORDER BY city_wise_orders DESC LIMIT 10;

-- =========================================
-- COUNT DELIVERED ORDERS BY STATE
-- =========================================

SELECT customer.customer_state,COUNT(*) AS delivered_by_state FROM customer 
INNER JOIN orders ON customer.customer_id=orders.customer_id 
WHERE orders.order_status='delivered' GROUP BY customer.customer_state
ORDER BY delivered_by_state DESC;

-- =========================================
-- COUNT CANCELED ORDERS BY STATE
-- =========================================

SELECT customer.customer_state,COUNT(*) AS canceled_by_state FROM customer
INNER JOIN orders ON customer.customer_id=orders.customer_id
WHERE orders.order_status='canceled' GROUP BY customer.customer_state
ORDER BY canceled_by_state DESC;

-- =========================================
-- FIND TOP 5 CITIES WITH HIGHEST DELIVERED ORDERS
-- =========================================

SELECT customer.customer_city,COUNT(*) AS highest_delivered_orders FROM customer
INNER JOIN orders ON customer.customer_id=orders.customer_id
WHERE orders.order_status='delivered' GROUP BY customer.customer_city
ORDER BY highest_delivered_orders DESC LIMIT 5;

-- =========================================
-- FIND YEARLY DELIVERED ORDERS BY STATE
-- =========================================

SELECT c.customer_state,EXTRACT(YEAR FROM o.order_delivered_customer_date::TIMESTAMP) 
AS order_year,COUNT(*) AS delivered_orders FROM customer AS c INNER JOIN orders AS o 
ON o.customer_id=c.customer_id WHERE o.order_status='delivered' 
GROUP BY order_year,c.customer_state ORDER BY order_year,c.customer_state;

-- =========================================
-- FIND TOP 5 STATES WITH HIGHEST DELIVERED ORDERS
-- =========================================

SELECT c.customer_state,COUNT(*) AS highest_delivered_orders FROM customer AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.order_status = 'delivered' 
GROUP BY c.customer_state ORDER BY highest_delivered_orders DESC LIMIT 5;

-- =========================================
-- FIND TOTAL ORDERS AND DELIVERED ORDERS BY STATE
-- =========================================

SELECT c.customer_state,COUNT(o.order_status) AS total_orders,COUNT(
CASE WHEN o.order_status='delivered' THEN 1 END) AS delivered_orders
FROM customer AS c INNER JOIN orders AS o ON c.customer_id=o.customer_id
GROUP BY c.customer_state ORDER BY total_orders DESC;

-- =========================================
-- FIND DELIVERY SUCCESS PERCENTAGE BY STATE
-- =========================================

SELECT c.customer_state,COUNT(o.order_status) AS total_orders,COUNT(
CASE WHEN o.order_status='delivered' THEN 1 END) AS delivered_orders,
ROUND(COUNT(CASE WHEN order_status='delivered' THEN 1 END)*100.0/COUNT(*),2)
AS success_percent FROM customer AS c INNER JOIN orders AS o ON c.customer_id=o.customer_id
GROUP BY c.customer_State ORDER BY success_percent DESC;


-- =========================================
-- FIND STATES HAVING MORE THAN 5000 DELIVERED ORDERS
-- =========================================

SELECT c.customer_state,COUNT(o.order_status) AS total_orders,COUNT(
CASE WHEN o.order_status='delivered' THEN 1 END) AS delivered_orders
FROM customer AS c INNER JOIN orders AS o ON c.customer_id=o.customer_id
GROUP BY c.customer_state HAVING COUNT(CASE WHEN o.order_status='delivered' THEN 1 END) 
> 5000 ORDER BY delivered_orders DESC;

-- =========================================
-- FIND STATES HAVING ABOVE AVERAGE ORDERS
-- =========================================

SELECT c.customer_state,COUNT(*) AS total_orders FROM customer AS c
INNER JOIN orders AS o ON c.customer_id=o.customer_id GROUP BY c.customer_state
HAVING COUNT(*) > (SELECT AVG(state_orders) FROM (
SELECT COUNT(*) AS state_orders FROM customer AS c INNER JOIN orders AS o 
ON c.customer_id=o.customer_id GROUP BY c.customer_state) AS state_order_counts)
ORDER BY total_orders DESC;

-- =========================================
-- FIND CUSTOMERS HAVING ABOVE AVERAGE ORDERS
-- =========================================

SELECT c.customer_id,COUNT(*) AS total_customers FROM customer AS c
INNER JOIN orders AS o ON c.customer_id=o.customer_id GROUP BY c.customer_id
HAVING COUNT(*) > (SELECT AVG(customer_orders) FROM(
SELECT c.customer_id,COUNT(*) AS customer_orders FROM customer AS c
INNER JOIN orders AS o ON c.customer_id=o.customer_id GROUP BY c.customer_id)
AS average_order_counts) ORDER BY total_customers DESC;

-- =========================================
-- FIND STATES HAVING ABOVE AVERAGE DELIVERY SUCCESS PERCENTAGE
-- =========================================

SELECT c.customer_state,ROUND(COUNT(
CASE WHEN o.order_status = 'delivered' THEN 1 END) * 100.0 / COUNT(*),2) 
AS success_percentage FROM customer AS c INNER JOIN orders AS o
ON c.customer_id = o.customer_id GROUP BY c.customer_state HAVING ROUND(
COUNT(CASE WHEN o.order_status = 'delivered' THEN 1 END) * 100.0 / COUNT(*),2)
>(SELECT AVG(state_success_percentage)FROM (SELECT ROUND(COUNT(
CASE WHEN o.order_status = 'delivered' THEN 1 END) * 100.0 / COUNT(*),2)
AS state_success_percentage FROM customer AS c INNER JOIN orders AS o 
ON c.customer_id = o.customer_id GROUP BY c.customer_state) AS state_success_data)
ORDER BY success_percentage DESC;