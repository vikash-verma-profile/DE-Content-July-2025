-- Task 1: Join customers and orders to get customer names with total order amount
SELECT 
    c.name AS customer_name,
    SUM(o.amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;

-- Task 2: Include region name from the regions table
SELECT 
    c.name AS customer_name,
    r.region_name,
    SUM(o.amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN regions r ON c.region = r.region_id
GROUP BY c.name, r.region_name;

-- Task 3: Filter records where total order amount > 10000
SELECT 
    c.name AS customer_name,
    r.region_name,
    SUM(o.amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN regions r ON c.region = r.region_id
GROUP BY c.name, r.region_name
HAVING SUM(o.amount) > 10000;

-- Task 4: Add HAVING clause for customers with more than 2 orders
SELECT 
    c.name AS customer_name,
    r.region_name,
    COUNT(o.id) AS order_count,
    SUM(o.amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN regions r ON c.region = r.region_id
GROUP BY c.name, r.region_name
HAVING COUNT(o.id) > 2 AND SUM(o.amount) > 10000;
