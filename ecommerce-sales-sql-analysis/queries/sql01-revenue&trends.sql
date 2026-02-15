-- Query 1: Total Revenue and Profit by Year

-- Question 1: What is the total sales by month?
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS total_sales
FROM ecommerce
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Question 2: What is the total profit by month?
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(profit) AS total_profit
FROM ecommerce
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Question 3: What is the month-over-month sales growth?

-- Using Common Table Expressions (CTEs) to calculate month-over-month sales growth
WITH monthly_sales_cte AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM ecommerce
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
),

-- Use LAG function to get the previous month's sales
lag_sales_cte AS (
    SELECT
        month,
        total_sales,
        LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales
    FROM monthly_sales_cte
)
SELECT
    month,
    total_sales,
    previous_month_sales,
    CASE
        WHEN previous_month_sales IS NULL OR previous_month_sales = 0 THEN NULL
        ELSE CONCAT(ROUND((total_sales - previous_month_sales) / previous_month_sales * 100, 2), '%')
    END AS sales_growth_percentage
FROM lag_sales_cte
ORDER BY month;

-- Question 4: What is the average order sales value?

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    AVG(sales) AS average_order_value_per_month
FROM ecommerce
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Question 5: Which month had the highest profit?

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(profit) AS total_profit
FROM ecommerce
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY total_profit DESC
LIMIT 1;
