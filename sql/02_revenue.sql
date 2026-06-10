-- ================================================================
--  02_revenue.sql
--  Project  : Ecommerce Sales Analysis
--  Author   : Shivam Nagpal
--  Date     : June 2026
--  Goal     : Analyse revenue trajectory, AOV trends and category
--             performance to answer: what is the financial health
--             of this business?
--  Note     : Revenue is calculated from order_items.line_total
--             (price x quantity per line). Cancelled orders are
--             excluded throughout. All amounts in INR.
-- ================================================================


-- ----------------------------------------------------------------
--  SECTION 1 — TOTAL REVENUE
--  Calibrate the order of magnitude first.
--  Are we a ₹1Cr business or a ₹100Cr business?
-- ----------------------------------------------------------------

-- Total revenue across all non-cancelled orders
-- Result: ₹33,38,19,092 — a mid-size ecommerce operation
SELECT 
    ROUND(SUM(oi.line_total)::numeric, 2) AS total_revenue
FROM ecom.order_items oi
JOIN ecom.orders o ON oi.order_id = o.order_id
WHERE LOWER(o.status) != 'cancelled';


-- ----------------------------------------------------------------
--  SECTION 2 — MONTHLY REVENUE, ORDER COUNT AND AOV
--  Breaking revenue down month by month to see the trend.
--  AOV = revenue / orders (not revenue / order_items)
-- ----------------------------------------------------------------

-- Monthly revenue, total orders and average order value
-- Key finding: Revenue peaked in October (Diwali season)
-- and has been declining since — down 16% by December
SELECT 
    DATE_TRUNC('month', o.created_at) AS month,
    ROUND(SUM(oi.line_total)::numeric, 2) AS monthly_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.line_total)::numeric / 
        COUNT(DISTINCT o.order_id), 2) AS aov
FROM ecom.order_items oi
JOIN ecom.orders o ON oi.order_id = o.order_id
WHERE LOWER(o.status) != 'cancelled'
GROUP BY DATE_TRUNC('month', o.created_at)
ORDER BY month;


-- ----------------------------------------------------------------
--  SECTION 3 — CATEGORY REVENUE BY MONTH
--  Which verticals drive revenue and how do they trend?
--  Using self join on categories to get parent category names
--  since products link to sub-categories not parent categories
-- ----------------------------------------------------------------

-- Monthly revenue broken down by parent category
-- Key finding: Apparel leads every month, same ranking throughout
-- All categories peak in October and decline together
SELECT 
    parent_c.category_name AS category,
    DATE_TRUNC('month', o.created_at) AS month,
    ROUND(SUM(oi.line_total)::numeric, 2) AS monthly_revenue
FROM ecom.order_items oi
JOIN ecom.orders o ON oi.order_id = o.order_id
JOIN ecom.product_variants pv ON oi.variant_id = pv.variant_id
JOIN ecom.products p ON pv.product_id = p.product_id
JOIN ecom.categories c ON p.category_id = c.category_id
JOIN ecom.categories parent_c ON c.parent_id = parent_c.category_id
WHERE c.parent_id IS NOT NULL
AND LOWER(o.status) != 'cancelled'
GROUP BY parent_c.category_name, DATE_TRUNC('month', o.created_at)
ORDER BY month, monthly_revenue DESC;


-- ----------------------------------------------------------------
--  SECTION 4 — SANITY CHECK
--  Sum of monthly revenues should equal total revenue.
--  Order count in join should match filtered orders table.
-- ----------------------------------------------------------------

-- Verify no double counting in our join
-- Should match total_orders from orders table minus cancelled
SELECT 
    COUNT(DISTINCT o.order_id) AS orders_in_join,
    ROUND(SUM(oi.line_total)::numeric, 2) AS total_revenue_check
FROM ecom.order_items oi
JOIN ecom.orders o ON oi.order_id = o.order_id
WHERE LOWER(o.status) != 'cancelled';
-- Result: 37,956 orders — matches 40,000 minus ~2,044 cancelled