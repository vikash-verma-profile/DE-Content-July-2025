-- Indexed JOIN: Test query speed
EXPLAIN ANALYZE
SELECT e.name, p.proj_name
FROM Employees e
JOIN Projects p ON e.emp_id = p.emp_id
WHERE e.department = 'Engineering'
LIMIT 50;

-- Filtered query using department index
SELECT name FROM Employees
WHERE department = 'HR'
LIMIT 100;

-- Update by indexed PK
UPDATE Employees
SET salary = salary + 1000
WHERE emp_id = 555;

-- Find employees without projects
SELECT e.name
FROM Employees e
LEFT JOIN Projects p ON e.emp_id = p.emp_id
WHERE p.emp_id IS NULL
LIMIT 100;
