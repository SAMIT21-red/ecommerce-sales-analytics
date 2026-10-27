/*
==========================================
E-Commerce Sales Analytics
SQL Business Queries
Author: Kaif Baig
==========================================

Contents
---------
5.1 SELECT
5.2 WHERE
5.3 ORDER BY
5.4 GROUP BY
5.5 HAVING
5.6 JOIN
5.7 CASE WHEN
5.8 Window Functions
5.9 Business Queries
5.10 SQL vs Pandas
*/

--------------------------------------------------
-- 5.1 SELECT
--------------------------------------------------

-- Show all orders
SELECT *
FROM orders;

-- Show all products
SELECT *
FROM products;

-- Show all website sessions
SELECT *
FROM website_sessions;


--------------------------------------------------
-- 5.2 WHERE
--------------------------------------------------

-- Orders above $100
SELECT *
FROM orders
WHERE price_usd > 100;

-- Orders placed in 2013
SELECT *
FROM orders
WHERE YEAR(created_at) = 2013;

-- Website sessions from gsearch
SELECT *
FROM website_sessions
WHERE utm_source = 'gsearch';

--------------------------------------------------
-- 5.3 ORDER BY
--------------------------------------------------

-- Highest priced orders
SELECT *
FROM orders
ORDER BY price_usd DESC;

-- Lowest priced orders
SELECT *
FROM orders
ORDER BY price_usd ASC;

-- Latest orders
SELECT *
FROM orders
ORDER BY created_at DESC;

-- Oldest orders
SELECT *
FROM orders
ORDER BY created_at ASC;

-- Products A to Z
SELECT *
FROM products
ORDER BY product_name ASC;


--------------------------------------------------
-- 5.4 GROUP BY
--------------------------------------------------

-- Total revenue by product
SELECT
    primary_product_id,
    SUM(price_usd) AS Total_Revenue
FROM orders
GROUP BY primary_product_id;

-- Number of orders by product
SELECT
    primary_product_id,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY primary_product_id;

-- Average order value by product
SELECT
    primary_product_id,
    AVG(price_usd) AS Average_Order_Value
FROM orders
GROUP BY primary_product_id;

-- Revenue by year
SELECT
    YEAR(created_at) AS Year,
    SUM(price_usd) AS Total_Revenue
FROM orders
GROUP BY YEAR(created_at);

-- Orders by year
SELECT
    YEAR(created_at) AS Year,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY YEAR(created_at);

-- Revenue by month
SELECT
    MONTH(created_at) AS Month,
    SUM(price_usd) AS Total_Revenue
FROM orders
GROUP BY MONTH(created_at)
ORDER BY Month;

-- Average order value by year
SELECT
    YEAR(created_at) AS Year,
    AVG(price_usd) AS Average_Order_Value
FROM orders
GROUP BY YEAR(created_at);


--------------------------------------------------
-- 5.5 HAVING
--------------------------------------------------

-- Products with revenue above $100,000
SELECT
    primary_product_id,
    SUM(price_usd) AS Total_Revenue
FROM orders
GROUP BY primary_product_id
HAVING SUM(price_usd) > 100000;

-- Products with more than 5000 orders
SELECT
    primary_product_id,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY primary_product_id
HAVING COUNT(order_id) > 5000;

-- Years with revenue above $500,000
SELECT
    YEAR(created_at) AS Year,
    SUM(price_usd) AS Total_Revenue
FROM orders
GROUP BY YEAR(created_at)
HAVING SUM(price_usd) > 500000;


--------------------------------------------------
-- 5.6 JOIN
--------------------------------------------------

-- Orders with product names
SELECT
    o.order_id,
    p.product_name,
    o.price_usd
FROM orders AS o
INNER JOIN products AS p
ON o.primary_product_id = p.product_id;

-- Revenue by product name
SELECT
    p.product_name,
    SUM(o.price_usd) AS Total_Revenue
FROM orders AS o
INNER JOIN products AS p
ON o.primary_product_id = p.product_id
GROUP BY p.product_name;

-- Total orders by product
SELECT
    p.product_name,
    COUNT(o.order_id) AS Total_Orders
FROM orders AS o
INNER JOIN products AS p
ON o.primary_product_id = p.product_id
GROUP BY p.product_name;


--------------------------------------------------
-- 5.7 CASE WHEN
--------------------------------------------------

-- Categorize orders by value
SELECT
    order_id,
    price_usd,

    CASE
        WHEN price_usd >= 100 THEN 'High Value'
        WHEN price_usd >= 50 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Order_Category

FROM orders;

-- Categorize products by revenue
SELECT
    primary_product_id,
    SUM(price_usd) AS Revenue,

    CASE
        WHEN SUM(price_usd) >= 500000 THEN 'Best Seller'
        ELSE 'Needs Improvement'
    END AS Product_Status

FROM orders
GROUP BY primary_product_id;

-- Categorize customers by order count
SELECT
    user_id,
    COUNT(order_id) AS Total_Orders,

    CASE
        WHEN COUNT(order_id) >= 3 THEN 'Returning Customer'
        ELSE 'New Customer'
    END AS Customer_Type

FROM orders
GROUP BY user_id;


--------------------------------------------------
-- 5.8 Window Functions
--------------------------------------------------

-- Rank orders by price
SELECT
    order_id,
    price_usd,

    RANK() OVER (
        ORDER BY price_usd DESC
    ) AS Price_Rank

FROM orders;

-- Row number by latest orders
SELECT
    order_id,
    created_at,

    ROW_NUMBER() OVER (
        ORDER BY created_at DESC
    ) AS Row_Num

FROM orders;

-- Dense ranking of products by revenue
SELECT
    primary_product_id,
    SUM(price_usd) AS Revenue,

    DENSE_RANK() OVER (
        ORDER BY SUM(price_usd) DESC
    ) AS Revenue_Rank

FROM orders
GROUP BY primary_product_id;

--------------------------------------------------
-- 5.9 Business Queries
--------------------------------------------------

-----------------------------
-- Product Queries
-----------------------------

-- Revenue by Product
SELECT
    p.product_name,
    SUM(o.price_usd) AS Total_Revenue
FROM orders o
JOIN products p
ON o.primary_product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Revenue DESC;

-- Top Selling Products
SELECT
    p.product_name,
    COUNT(o.order_id) AS Total_Orders
FROM orders o
JOIN products p
ON o.primary_product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Orders DESC;

-- Average Selling Price by Product
SELECT
    p.product_name,
    AVG(o.price_usd) AS Average_Price
FROM orders o
JOIN products p
ON o.primary_product_id = p.product_id
GROUP BY p.product_name;


-----------------------------
-- Customer Queries
-----------------------------

-- Top 10 Customers by Revenue
SELECT
    user_id,
    SUM(price_usd) AS Revenue
FROM orders
GROUP BY user_id
ORDER BY Revenue DESC
LIMIT 10;

-- Repeat Customers
SELECT
    user_id,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY user_id
HAVING COUNT(order_id) > 1;

-- Average Revenue per Customer
SELECT
    AVG(Customer_Revenue) AS Average_Revenue
FROM (
    SELECT
        user_id,
        SUM(price_usd) AS Customer_Revenue
    FROM orders
    GROUP BY user_id
);


-----------------------------
-- Sales Queries
-----------------------------

-- Revenue by Year
SELECT
    YEAR(created_at) AS Year,
    SUM(price_usd) AS Revenue
FROM orders
GROUP BY YEAR(created_at);

-- Revenue by Month
SELECT
    MONTH(created_at) AS Month,
    SUM(price_usd) AS Revenue
FROM orders
GROUP BY MONTH(created_at)
ORDER BY Month;

-- Average Order Value
SELECT
    AVG(price_usd) AS Average_Order_Value
FROM orders;

-- Highest Revenue Month
SELECT
    MONTH(created_at) AS Month,
    SUM(price_usd) AS Revenue
FROM orders
GROUP BY MONTH(created_at)
ORDER BY Revenue DESC
LIMIT 1;


-----------------------------
-- Marketing Queries
-----------------------------

-- Sessions by Source
SELECT
    utm_source,
    COUNT(*) AS Sessions
FROM website_sessions
GROUP BY utm_source
ORDER BY Sessions DESC;

-- Sessions by Campaign
SELECT
    utm_campaign,
    COUNT(*) AS Sessions
FROM website_sessions
GROUP BY utm_campaign
ORDER BY Sessions DESC;

-- Device Performance
SELECT
    device_type,
    COUNT(*) AS Sessions
FROM website_sessions
GROUP BY device_type;


-----------------------------
-- Website Queries
-----------------------------

-- Most Viewed Pages
SELECT
    pageview_url,
    COUNT(*) AS Views
FROM website_pageviews
GROUP BY pageview_url
ORDER BY Views DESC;

-- Landing Pages
SELECT
    landing_page,
    COUNT(*) AS Sessions
FROM website_sessions
GROUP BY landing_page
ORDER BY Sessions DESC;

-- Exit Pages
SELECT
    pageview_url,
    COUNT(*) AS Exits
FROM website_pageviews
WHERE is_exit_page = 1
GROUP BY pageview_url
ORDER BY Exits DESC;


-----------------------------
-- Executive Queries
-----------------------------

-- Top Revenue Products
SELECT
    p.product_name,
    SUM(o.price_usd) AS Revenue
FROM orders o
JOIN products p
ON o.primary_product_id = p.product_id
GROUP BY p.product_name
ORDER BY Revenue DESC
LIMIT 5;

-- Top Revenue Customers
SELECT
    user_id,
    SUM(price_usd) AS Revenue
FROM orders
GROUP BY user_id
ORDER BY Revenue DESC
LIMIT 5;

-- Best Performing Year
SELECT
    YEAR(created_at) AS Year,
    SUM(price_usd) AS Revenue
FROM orders
GROUP BY YEAR(created_at)
ORDER BY Revenue DESC
LIMIT 1;


--------------------------------------------------
-- 5.10 SQL vs Pandas
--------------------------------------------------

/*
SQL                               Pandas
--------------------------------------------------------
SELECT                            df
WHERE                             Boolean Indexing
ORDER BY                          sort_values()
GROUP BY                          groupby()
HAVING                            groupby().filter()
JOIN                              merge()
CASE WHEN                         if-elif / np.where()
ROW_NUMBER()                      cumcount()
RANK()                            rank()
DENSE_RANK()                      rank(method="dense")
*/

