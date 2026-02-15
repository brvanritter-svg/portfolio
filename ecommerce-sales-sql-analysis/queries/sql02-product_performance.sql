-- Query 2: Product Performance Analysis

-- Question 6: Top 10 products by total sales?

SELECT
    product_name,
    SUM(sales) AS total_sales
FROM ecommerce
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Question 7: Top 10 products by total profit?

SELECT
    product_name,
    SUM(profit) AS total_profit
FROM ecommerce
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Question 8: Which categories generate the most revenue?

SELECT
    category,
    SUM(sales) AS total_sales
FROM ecommerce
GROUP BY category
ORDER BY total_sales DESC;

-- Question 9: Which categories are the most profitable?

SELECT
    category,
    SUM(profit) AS total_profit
FROM ecommerce
GROUP BY category
ORDER BY total_profit DESC;

-- Question 10: Which products have high sales but low profit?

WITH sales_cte AS (
    SELECT
        product_name,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        CASE WHEN SUM(sales) > 0 THEN SUM(profit) / SUM(sales) ELSE 0 END AS profit_margin
    FROM ecommerce
GROUP BY product_name
),
avereges_cte AS (
    SELECT
        AVG(total_sales) AS avg_total_sales,
        AVG(profit_margin) AS avg_profit_margin
    FROM sales_cte
)

SELECT
    product_name,
    total_sales,
    total_profit
FROM sales_cte s
CROSS JOIN avereges_cte a
WHERE s.total_sales > a.avg_total_sales
AND profit_margin < a.avg_profit_margin
ORDER BY total_sales DESC;