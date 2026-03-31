SELECT
-- Dates
transaction_date AS purchase_date,
DAYNAME(transaction_date) AS day_name,
MONTHNAME(transaction_date) AS month_name,
DAYOFMONTH(transaction_date) AS day_of_month,
CASE
WHEN DAYNAME(transaction_date) IN ('Sun', 'Sat') THEN 'Weekend'
ELSE 'Weekday'
END AS day_classification,
-- Time Buckets
CASE
WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '0.1 Mo
WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '0.2 Af
WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN '0.3 Evening'
END AS time_buckets,
-- Counts
COUNT(*) AS number_of_sales,
COUNT(DISTINCT product_id) AS number_of_products,
COUNT(DISTINCT store_id) AS number_stores,
-- Revenue
SUM(transaction_qty * unit_price) AS revenue_per_day,
-- Categorical Columns
store_location,
product_category,
product_detail
FROM workspace.default.coffeeshop
GROUP BY
transaction_date,
DAYNAME(transaction_date),
MONTHNAME(transaction_date),
DAYOFMONTH(transaction_date),
CASE
WHEN DAYNAME(transaction_date) IN ('Sun', 'Sat') THEN 'Weekend'
ELSE 'Weekday'
END,
CASE
WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '0.1 Mo
WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '0.2 Af
WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN '0.3 Evening'
END,
store_location,
product_category,
product_detail;
