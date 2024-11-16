
(Q1)

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT,
    hire_date DATE,
    salary DECIMAL(10, 2),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);
CREATE TABLE Salaries (
    emp_id INT,
    salary DECIMAL(10, 2),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (emp_id, start_date),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);


(Q2)
A. 
SELECT c.customer_id
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
LEFT JOIN Loans l ON c.customer_id = l.customer_id
WHERE l.loan_id IS NULL;

B.
SELECT c.customer_id
FROM Customers c
WHERE c.street = (SELECT street FROM Customers WHERE customer_id = '12345')
  AND c.city = (SELECT city FROM Customers WHERE customer_id = '12345')
  AND c.customer_id != '12345';

C.
SELECT DISTINCT b.branch_name
FROM Branches b
JOIN Branch_Customers bc ON b.branch_id = bc.branch_id
JOIN Customers c ON bc.customer_id = c.customer_id
WHERE c.city = 'Harrison';

(Q3):
A. 
SELECT product_id,
       order_date,
       qty,
       SUM(qty) OVER (PARTITION BY product_id ORDER BY order_date) AS cumulative_qty
FROM demand;

B.
WITH RankedDays AS (
    SELECT product_id,
           order_date,
           qty,
           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY qty ASC) AS rank
    FROM demand
)
SELECT product_id,
       order_date,
       qty
FROM RankedDays
WHERE rank <= 2;
