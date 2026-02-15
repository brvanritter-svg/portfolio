/* CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Create the sales table
CREATE TABLE IF NOT EXISTS ecommerce(
    order_date DATE,
    product_name VARCHAR(255),
    category VARCHAR(255),
    region VARCHAR(255),
    quantity INT,
    sales DECIMAL(10, 2),
    profit DECIMAL(10, 2)
);

-- Insert data into the ecommerce table

LOAD DATA INFILE '/var/lib/mysql-files/ecommerce_sales_data.csv'
INTO TABLE ecommerce
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_date, product_name, category, region, quantity, sales, profit); */
