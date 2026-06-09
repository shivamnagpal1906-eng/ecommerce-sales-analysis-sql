-- ============================================
-- 01_exploration.sql
-- Ecommerce Sales Analysis
-- Author: Shivam Nagpal
-- Purpose: Initial schema exploration to understand
--          the business, its scale, and data quality
-- ============================================


-- STEP 1: List all tables in the ecom schema
-- Getting a full map of what exists before diving in
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'ecom';


-- STEP 2: Preview core tables
-- Reading 10 rows from each key table to understand structure and content

-- Customers: demographics, location, acquisition channel, lifecycle stage
SELECT * FROM ecom.customers LIMIT 10;

-- Orders: order lifecycle, amounts, discounts, shipping
SELECT * FROM ecom.orders LIMIT 10;

-- Products: product names, brand, category
SELECT * FROM ecom.products LIMIT 10;

-- Order items: links orders to product variants, quantities, prices
SELECT * FROM ecom.order_items LIMIT 10;

-- Categories: what does this business actually sell?
SELECT * FROM ecom.categories;


-- STEP 3: Business scale
-- Answering the CTO's core questions -- how big is this business?

-- Total number of registered customers
SELECT COUNT(*) AS total_customers FROM ecom.customers;

-- Total number of orders placed
SELECT COUNT(*) AS total_orders FROM ecom.orders;

-- How many unique customers actually placed at least one order?
-- 9827 out of 10000 -- unusually high conversion rate
SELECT COUNT(DISTINCT customer_id) AS customers_who_ordered
FROM ecom.orders;

-- Time span of the data
-- Data covers Sep 28 to Dec 27 2025 -- only 3 months, festive season
SELECT MIN(created_at) AS first_order, MAX(created_at) AS last_order
FROM ecom.orders;

-- Average order value
-- Rs 8878 -- this is a premium/mid-to-high ticket business
SELECT ROUND(AVG(total)::numeric, 2) AS avg_order_value
FROM ecom.orders;


-- STEP 4: Category breakdown
-- Which sub-categories drive the most orders?
-- Skincare leads, fairly even spread across all categories
SELECT c.category_name, COUNT(oi.order_id) AS total_orders
FROM ecom.order_items oi
JOIN ecom.product_variants pv ON oi.variant_id = pv.variant_id
JOIN ecom.products p ON pv.product_id = p.product_id
JOIN ecom.categories c ON p.category_id = c.category_id
WHERE c.parent_id IS NOT NULL
GROUP BY c.category_name
ORDER BY total_orders DESC;


-- STEP 5: Order status breakdown
-- CRITICAL: Found data quality issue -- same status in mixed cases
-- 'delivered', 'DELIVERED', 'Shipped', 'SHIPPED' all exist
-- This will cause incorrect counts if not cleaned
SELECT status, COUNT(*) AS count
FROM ecom.orders
GROUP BY status
ORDER BY count DESC;