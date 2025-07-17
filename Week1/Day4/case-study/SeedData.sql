CREATE TABLE users (
  user_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);

INSERT INTO users (user_id, name, email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com'),
(4, 'Diana', 'diana@example.com'),
(5, 'Ethan', 'ethan@example.com');


CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  user_id INT,
  order_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO orders (order_id, user_id, order_date) VALUES
(101, 1, '2024-01-05'),
(102, 1, '2024-03-10'),
(103, 2, '2024-02-15'),
(104, 3, '2024-02-20'),
(105, 3, '2024-04-05'),
(106, 4, '2024-06-01'),
(107, 5, '2024-06-10'),
(108, 1, '2024-06-30');

CREATE TABLE order_items (
  item_id INT PRIMARY KEY,
  order_id INT,
  product_name VARCHAR(100),
  quantity INT,
  price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO order_items (item_id, order_id, product_name, quantity, price) VALUES
(1, 101, 'Keyboard', 1, 30.00),
(2, 101, 'Mouse', 2, 15.00),
(3, 102, 'Monitor', 1, 150.00),
(4, 103, 'USB Cable', 3, 5.00),
(5, 104, 'Laptop', 1, 700.00),
(6, 105, 'Headphones', 2, 80.00),
(7, 106, 'Tablet', 1, 200.00),
(8, 107, 'Power Bank', 1, 40.00),
(9, 108, 'SSD Drive', 1, 100.00);


CREATE VIEW user_order_analytics AS
SELECT
  u.user_id,
  u.name,
  o.order_id,
  o.order_date,
  SUM(oi.quantity * oi.price) AS order_total,
  ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY o.order_date) AS order_rank,
  LAG(o.order_date) OVER (PARTITION BY u.user_id ORDER BY o.order_date) AS last_order_date,
  DATEDIFF(o.order_date, LAG(o.order_date) OVER (PARTITION BY u.user_id ORDER BY o.order_date)) AS days_since_last_order,
  SUM(SUM(oi.quantity * oi.price)) OVER (PARTITION BY u.user_id ORDER BY o.order_date) AS running_total
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY u.user_id, u.name, o.order_id, o.order_date;
