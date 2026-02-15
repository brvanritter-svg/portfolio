-- Regional Performance Analysis

-- Question 11: Which regions generate the most sales?

SELECT
    region,
    SUM(sales) AS total_sales
FROM ecommerce
GROUP BY region
ORDER BY total_sales DESC;

-- Question 12: Which region has the highest profit margin?

SELECT
    region,
    SUM(profit) AS total_profit,
    SUM(sales) AS total_sales,
    CASE
        WHEN SUM(sales) = 0 THEN NULL
        ELSE CONCAT(ROUND(SUM(profit) / SUM(sales) * 100 , 2), '%')
    END AS profit_margin_percentage
FROM ecommerce
GROUP BY region
ORDER BY profit_margin_percentage DESC;