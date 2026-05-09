-- =========================================
-- CREATE CUSTOMER TABLE
-- =========================================

CREATE TABLE customer(
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT
);

-- =========================================
-- CREATE ORDERS TABLE
-- =========================================

CREATE TABLE orders(
    order_id TEXT PRIMARY KEY,
    customer_id TEXT,
	order_status TEXT,
	order_purchase_timestamp TEXT,
	order_approved_at TEXT,
	order_delivered_carrier_date TEXT,
	order_delivered_customer_date TEXT,
	order_estimated_delivery_date TEXT
);

-- =========================================
-- REMOVE HEADER ROW IMPORTED AS DATA
-- =========================================

DELETE FROM orders
WHERE order_purchase_timestamp = 'order_purchase_timestamp';




