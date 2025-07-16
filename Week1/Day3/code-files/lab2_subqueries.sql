-- Task 1: Most recent order amount per customer using subquery
SELECT 
    c.name AS customer_name,
    (
        SELECT o.amount
        FROM orders o
        WHERE o.customer_id = c.id
        ORDER BY o.order_date DESC
        LIMIT 1
    ) AS most_recent_order_amount
FROM customers c;

-- Task 2: Count total, >5000, and <1000 order amounts
SELECT 
    customer_id,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN amount > 5000 THEN 1 ELSE 0 END) AS orders_above_5000,
    SUM(CASE WHEN amount < 1000 THEN 1 ELSE 0 END) AS orders_below_1000
FROM orders
GROUP BY customer_id;

-- Task 3: Customer with the highest number of orders
SELECT 
    c.name AS top_customer, 
    order_stats.order_count
FROM (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
    ORDER BY order_count DESC
    LIMIT 1
) AS order_stats
JOIN customers c ON c.id = order_stats.customer_id;
