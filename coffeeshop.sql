-- Sales Performance Analysis: Calculate total sales revenue over time (daily, weekly, monthly)

-- Total Sales Revenue Over Time (Daily):
SELECT 
    transaction_date, 
	-- There no column for total revenue hence the multiplication
    SUM(unit_price * transaction_qty) AS total_revenue
FROM coffee_shop
GROUP BY transaction_date
ORDER BY transaction_date;

-- Total Sales Revenue Over Time (weekly):
SELECT 
    DATE_TRUNC('week',transaction_date) AS "Week_start_date", 
    SUM(unit_price * transaction_qty) AS total_revenue
FROM coffee_shop
GROUP BY "Week_start_date"
ORDER BY "Week_start_date";

-- Total Sales Revenue Over Time (monthly)
SELECT 
    TO_CHAR(DATE_TRUNC('month', transaction_date), 'Month') AS "month_start_date", 
    SUM(unit_price * transaction_qty) AS total_revenue
FROM coffee_shop
GROUP BY "month_start_date"
-- orders the months chronologically based on their start dates.
ORDER BY MIN(DATE_TRUNC('month', transaction_date));

-- Percentage of total unit price by product type
WITH TotalUnitPrice AS (
    SELECT 
        SUM(unit_price) AS total_unit_price
    FROM 
        coffee_shop
)
SELECT
    cs.product_type,
    --SUM(cs.unit_price) AS total_unit_price,
    Round((SUM(cs.unit_price) / t.total_unit_price) * 100,2) AS percentage_of_total
FROM
    coffee_shop cs
CROSS JOIN
    TotalUnitPrice t
GROUP BY
    cs.product_type, t.total_unit_price
ORDER BY
    percentage_of_total DESC;
	
-- Calculate transaction quantity by product_category and store_location
SELECT 
    product_category,
	store_location,
    SUM(transaction_qty) AS total_quantity
FROM coffee_shop
GROUP BY product_category,
	store_location
ORDER BY total_quantity DESC;

-- Top 5 best selling product category by value/quantity
SELECT 
    product_category,
    SUM(unit_price * transaction_qty) AS total_revenue,
	SUM(transaction_qty) AS total_quantity
FROM coffee_shop
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 5

-- Customer Behavior Analysis (Average Transaction Size)
SELECT 
    Round(AVG(transaction_qty),2) AS avg_transaction_size
FROM coffee_shop;

-- tore Performance Analysis (Sales Quantity by Store)
SELECT 
    store_id, 
    SUM(transaction_qty) AS total_quantity_sold
FROM coffee_shop
GROUP BY store_id
ORDER BY total_quantity_sold DESC;

-- Price Analysis (Relationship Between Unit Price and Sales Quantity)
SELECT 
    Round(AVG(unit_price),2) AS avg_unit_price, 
    Round(AVG(transaction_qty),2) AS avg_transaction_qty
FROM coffee_shop;



