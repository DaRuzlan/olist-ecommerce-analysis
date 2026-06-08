-- ===================================
-- Olist E-Commerce Sales Analysis 
-- Author: Ruslan
-- Dataset: Brazilian E-Commerce (Olist/Kaggle)
-- ===================================

CREATE DATABASE olist_ecommerce;

USE olist_ecommerce;

-- ===================================
-- Stage 1: DATANBASE SETUP
-- ===================================

CREATE TABLE customers (
customer_id VARCHAR (50) PRIMARY KEY,
customer_unique_id VARCHAR (50),
customer_zip_code VARCHAR (10),
customer_city VARCHAR (100), 
customer_state VARCHAR (5)
);

CREATE TABLE orders (
order_id VARCHAR (50) PRIMARY KEY,
customer_id VARCHAR (50),
order_status VARCHAR (30),
order_purchase_timestamp DATETIME,
order_delivered_customer_date DATETIME,
order_estimated_delivery_date DATETIME
);

CREATE TABLE products (
product_id VARCHAR (50) PRIMARY KEY,
product_category_name VARCHAR (100),
product_weight_g INT,
product_length_cm INT,
product_height_cm INT, 
product_width_cm INT
);

CREATE TABLE sellers (
seller_id VARCHAR (50) PRIMARY KEY,
seller_zip_code VARCHAR (10),
seller_city VARCHAR (100),
seller_state VARCHAR (5)
);

CREATE TABLE order_items (
order_id VARCHAR (50),
order_item_id INT, 
product_id VARCHAR (50), 
seller_id VARCHAR (50),
price DECIMAL (10,2),
freight_value DECIMAL (10,2)
);

CREATE TABLE payments (
order_id VARCHAR(50),
payment_sequential INT, 
payment_type VARCHAR (30), 
payment_installments INT,
payment_value DECIMAL (10,2)
);

-- ===================================
-- STAGE 2: BASIC ANALYSIS
-- ===================================

SET FOREIGN_KEY_CHECKS = 1;

-- TOTAL NUMBER OF ORDERS
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM sellers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payments;

SELECT COUNT(*) AS total_orders FROM orders;

-- WHAT ORDER STATUSES EXIST AND HOW MANY OF EACH
SELECT order_status, COUNT(*) AS total 
FROM orders
GROUP BY order_status
ORDER BY total DESC;

-- WHAT RAE THE TOP 10 MOST EXPENSIVE PRODUCTS SOLD
SELECT product_id, price 
FROM order_items
ORDER BY price DESC
LIMIT 10;

-- WHAT IS THE TOTAL REVENUE ACCROSS ALL ORDERS
SELECT ROUND(SUM(payment_value),2) AS total_revenue
FROM payments;

-- WHAT IS THE AVERAGE VALUE OF ORDER
SELECT ROUND(AVG(payment_value),2) AS avg_order_value
FROM payments;

-- WHICH MONTHS HAD THE MOST ORDERS
SELECT 
	MONTH(order_purchase_timestamp) AS month,
    YEAR(order_purchase_timestamp) AS year,
    COUNT(*) AS total_orders
    FROM orders
    WHERE order_status = 'delivered'
    GROUP BY year, month
    ORDER BY year, month;

-- WHAT PAYMENT METHODS DO CUSTOMERS PREFER
SELECT 
	payment_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(payment_value),2) total_revenue 
    FROM payments
    GROUP BY payment_type
    ORDER BY total_transactions DESC;

-- WHAT IS THE TOTAL REVENUE PER ORDER STATUS
SELECT 
	o.order_status,
	COUNT(o.order_id) AS total_orders,
	ROUND(SUM(p.payment_value),2) AS total_revenue
	FROM orders o
	INNER JOIN payments p ON o.order_id = p.order_id
	GROUP BY o.order_status
	ORDER BY total_revenue DESC;

-- WHAT PRODUCTS GENERATED THE MOST REVENUE
SELECT 
	p.product_category_name,
    COUNT(oi.order_id) AS total_orders,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- WHICH SELLERS GENERATED THE MOST REVENUE
SELECT 
	oi.seller_id,
    COUNT(oi.order_id) AS total_orders,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM order_items oi
INNER JOIN sellers s ON oi.seller_id = s.seller_id
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- WHAT SELLERS HAVE PROCESSED MORE THAN 100 ORDERS
SELECT 
	oi.seller_id,
    COUNT(oi.order_id) AS total_orders,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM order_items oi
INNER JOIN sellers s ON oi.seller_id = s.seller_id
GROUP BY oi.seller_id
HAVING total_orders > 100
ORDER BY total_revenue DESC;


SELECT 
	order_id,
    payment_value,
    CASE 
		WHEN payment_value < 50 THEN 'Small'
        WHEN payment_value BETWEEN 50 AND 200 THEN 'Medium'
        WHEN payment_value > 200 THEN 'Large'
	END AS order_size
FROM payments
ORDER BY payment_value DESC 
LIMIT 100;

-- CLASSIFYING ORDERS BY SIZE USING CASE
SELECT 
	CASE
		WHEN payment_value < 50 THEN 'Small'
        WHEN payment_value BETWEEN 50 AND 200 THEN 'Medium'
        WHEN payment_value > 200 THEN 'Large'
	END AS order_size,
    COUNT(*) AS total_orders,
    ROUND(SUM(payment_value),2) AS total_revenue
FROM payments 
GROUP BY order_size
ORDER BY total_revenue DESC;






