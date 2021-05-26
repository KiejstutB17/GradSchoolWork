-- Date and String Functions

-- 01 - # of orders per day
SELECT 
	DATE(OrderDate) AS OrderDateDay,
	COUNT(OrderNumber) AS DailyOrders
FROM Orders
GROUP BY OrderDate;

-- 02 - # of orders per month
SELECT 
	LEFT(OrderDate, 7) AS OrderMonth,
	COUNT(OrderNumber) AS MonthlyOrders
FROM Orders
GROUP BY OrderMonth;

-- 03 - # of orders per quarter
SELECT 
	YEAR(OrderDate) AS OrderYear,
	QUARTER(OrderDate) AS OrderQuarter,
	COUNT(OrderNumber) AS QuarterlyOrders
FROM Orders
GROUP BY 
	QUARTER(OrderDate),
	YEAR(OrderDate);

-- 04 - # of orders and revenue per day
SELECT 
	DATE(OrderDate),
	COUNT(DISTINCT(o.OrderNumber)) AS DailyOrders,
	SUM((QuotedPrice * QuantityOrdered)) AS DailyRevenue	
FROM Orders o
JOIN Order_Details od 
	ON o.OrderNumber = od.OrderNumber 
GROUP BY DATE(OrderDate);


-- Create an Orders2021 table to simulate recent data

-- Copy the Orders schema to Orders2021
CREATE TABLE Orders2021 LIKE Orders;

-- Select Jan - Mar 2018 data into Orders2021
INSERT INTO Orders2021
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2018-01-01' AND '2018-03-31';

-- What would the OrderDate look like if we added 3 years to make the OrderDate year 2021?
SELECT
	OrderDate,
	DATE_ADD(OrderDate, INTERVAL 3 YEAR)
FROM Orders2021
LIMIT 10;

-- Update OrderDate to reflect 2021. Always add a WHERE to UPDATE and DELETE.
UPDATE Orders2021
SET OrderDate = DATE_ADD(OrderDate, INTERVAL 3 YEAR)
WHERE OrderDate BETWEEN '2018-01-01' AND '2018-03-31';

-- Verify update
SELECT 
	DATE(OrderDate) AS OrderDateDay,
	COUNT(*)
FROM Orders2021
GROUP BY OrderDateDay;



-- 05 - How many orders per day for the past month? Do not include orders from today.
-- Only use DATE functions in the WHERE and do not hard code dates.
SELECT
	DATE(OrderDate) AS OrderDateDay,
	COUNT(*) AS OrderCount
FROM Orders2021
WHERE OrderDate BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND DATE_SUB(CURDATE(), INTERVAL 1 DAY)
GROUP BY  OrderDateDay;


-- VIEW

-- 06 - Create a VIEW to hold the results for the order count and revenue per day, category, and product name for all dates
/*1. Identify Tables
 * Orders
 * 	OrderNumber
 * Order_Details
 * 	ProductNumber
 * Products
 * 	CateogryID
 * Categories
 * 
 * 2. Identify Foreign Keys
 * 3. GROUP BY
 * 4. Aggregate
 */

SELECT 
	COUNT(DISTINCT(o.OrderNumber)) AS OrderCount,
	(QuotedPrice * QuantityOrdered) AS RevenuePerDay,
	CategoryDescription,
	ProductName,
	OrderDate
FROM Orders o 
JOIN Order_Details od
	ON o.OrderNumber = od.OrderNumber 
JOIN Products p 
	ON od.ProductNumber = p.ProductNumber 
JOIN Categories c 
	ON p.CategoryID = c.CategoryID 
GROUP BY 
	OrderDate,
	CategoryDescription,
	ProductName;

CREATE OR REPLACE VIEW Orders_Summary AS
	SELECT 
		OrderDate,
		p.ProductNumber, 
		ProductName,
		CategoryDescription,
		COUNT(DISTINCT(o.OrderNumber)) AS Total_Orders,
		SUM(QuotedPrice*QuantityOrdered) AS Revenue
	FROM Orders o
	JOIN Order_Details od
		ON o.OrderNumber = od.OrderNumber 
	JOIN Products p
		ON od.ProductNumber = p.ProductNumber 
	JOIN Categories c
		ON p.CategoryID = c.CategoryID 
	GROUP BY 
		OrderDate,
		ProductNumber;
	
SELECT *
FROM Orders_Summary
WHERE Total_Orders > 2
	AND CategoryDescription = 'Bikes';


-- 07 - Using the VIEW, return the days and order count where 
-- the order count for products in the bikes category was greater than 2

SELECT *
FROM Orders_Summary
WHERE Total_Orders > 2
	AND CategoryDescription = 'Bikes';

-- Common Table Expression (CTE)

-- 08 - Using a CTE instead of a VIEW, return the days and order count 
-- where the order count for products in the bikes category was greater than 2
WITH Orders_Summary_CTE AS (
	SELECT 
		OrderDate,
		p.ProductNumber, 
		ProductName,
		CategoryDescription,
		COUNT(DISTINCT(o.OrderNumber)) AS Total_Orders,
		SUM(QuotedPrice*QuantityOrdered) AS Revenue
	FROM Orders o
	JOIN Order_Details od
		ON o.OrderNumber = od.OrderNumber 
	JOIN Products p
		ON od.ProductNumber = p.ProductNumber 
	JOIN Categories c
		ON p.CategoryID = c.CategoryID 
	GROUP BY 
		OrderDate,
		ProductNumber
)
SELECT *
FROM Orders_Summary_CTE
WHERE Total_Orders > 2
	AND CategoryDescription = 'Bikes';

-- 09 - What is the average daily revenue?
WITH Orders_Summary_CTE AS (
	SELECT 
		OrderDate,
		p.ProductNumber, 
		ProductName,
		CategoryDescription,
		COUNT(DISTINCT(o.OrderNumber)) AS Total_Orders,
		SUM(QuotedPrice*QuantityOrdered) AS Revenue
	FROM Orders o
	JOIN Order_Details od
		ON o.OrderNumber = od.OrderNumber 
	JOIN Products p
		ON od.ProductNumber = p.ProductNumber 
	JOIN Categories c
		ON p.CategoryID = c.CategoryID 
	GROUP BY 
		OrderDate,
		ProductNumber
)
SELECT
	DATE(OrderDate) AS DateOrderDate,
	AVG(Revenue)
FROM Orders_Summary_CTE
GROUP BY DateOrderDate;

-- 10 - What is the average revenue per category? 
WITH Orders_Summary_CTE AS (
	SELECT 
		OrderDate,
		p.ProductNumber, 
		ProductName,
		CategoryDescription,
		COUNT(DISTINCT(o.OrderNumber)) AS Total_Orders,
		SUM(QuotedPrice*QuantityOrdered) AS Revenue
	FROM Orders o
	JOIN Order_Details od
		ON o.OrderNumber = od.OrderNumber 
	JOIN Products p
		ON od.ProductNumber = p.ProductNumber 
	JOIN Categories c
		ON p.CategoryID = c.CategoryID 
	GROUP BY 
		OrderDate,
		ProductNumber
)
SELECT
	CategoryDescription,
	AVG(Revenue)
FROM Orders_Summary_CTE
GROUP BY CategoryDescription;


-- 11 - Compare revenue for yesterday and the day before for bikes and car racks.
-- Indicate if revenue decreased. 
/*
 * Orders2021 
 * 1. tables
 * 2.foreign keys
 * 3. How to calculate yesterday and the day before?
 * 4. Create CTE
 * 5. Join CTE with itself to get 2 days ago and yesterrday data on the same row
 */

WITH Orders_Summary_CTE AS (
	SELECT 
		o.OrderDate,
		p.ProductNumber, 
		ProductName,
		CategoryDescription,
		COUNT(DISTINCT(o.OrderNumber)) AS Total_Orders,
		SUM(QuotedPrice*QuantityOrdered) AS Revenue
	FROM Orders2021 o
	JOIN Order_Details od
		ON o.OrderNumber = od.OrderNumber 
	JOIN Products p
		ON od.ProductNumber = p.ProductNumber 
	JOIN Categories c
		ON p.CategoryID = c.CategoryID 
	WHERE OrderDate BETWEEN DATE_SUB(CURDATE(), INTERVAL 2 DAY) AND DATE_SUB(CURDATE(), INTERVAL 1 DAY)
	GROUP BY 
		OrderDate,
		ProductNumber
)
SELECT 
	YesterdayCTE.OrderDate AS YesterdayOrderDate,
	YesterdayCTE.Revenue AS YesterdayRevenue, 
	TwoDaysAgoCTE.OrderDate AS TwoDaysAgoOrderDate,
	TwoDaysAgoCTE.Revenue AS TwoDaysAgoRevenue,
	YesterdayCTE.CategoryDescription,
	YesterdayCTE.Revenue < TwoDaysAgoCTE.Revenue AS RevenueDecrease
FROM Orders_Summary_CTE YesterdayCTE
JOIN Orders_Summary_CTE TwoDaysAgoCTE
	ON YesterdayCTE.CategoryDescription = TwoDaysAgoCTE.CategoryDescription
WHERE YesterdayCTE.CategoryDescription IN ('Bikes', 'Car racks')
	AND YesterdayCTE.OrderDate = TwoDaysAgoCTE.OrderDate + 1;

-- date functs
SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) AS TwoDaysAgo, DATE_SUB(CURDATE(), INTERVAL 1 DAY) AS Yesterday; 
