/*
Host: kiejstutbunikiewicz.lmu.build
Username: kiejstut_dba
Password: sql_2021
*/



-- sakila Database

/*
1. Select all columns from the film table for PG-rated films. (1 point)
*/
SELECT *
FROM film
WHERE rating = 'PG';



/*
2. Select the customer_id, first_name, and last_name for the active customers (0 means inactive). Sort the customers by their last name and restrict the results to 10 customers. (1 point)
*/
SELECT customer_id, first_name, last_name 
FROM customer
WHERE active != 0
GROUP BY last_name 
LIMIT 10;

/*
3. Select customer_id, first_name, and last_name for all customers where the last name is Clark. (1 point)
*/
SELECT customer_id, first_name, last_name 
FROM customer
WHERE last_name = 'Clark';

/*
4. Select film_id, title, rental_duration, and description for films with a rental duration of 3 days. (1 point)
*/
SELECT film_id, title, rental_duration, description 
FROM film
WHERE rental_duration = 3;

SELECT rental_duration 
FROM film;

/*
5. Select film_id, title, rental_rate, and rental_duration for films that can be rented for more than 1 day and at a cost of $0.99 or more. Sort the results by rental_rate then rental_duration. (2 points)
*/
SELECT film_id, title, rental_rate, rental_duration 
FROM film
WHERE rental_duration > 1 
	AND rental_rate >= 0.99
ORDER BY rental_rate, rental_duration;

/*
6. Select film_id, title, replacement_cost, and length for films that cost 9.99 or 10.99 to replace and have a running time of 60 minutes or more. (2 points)
*/
SELECT film_id, title, replacement_cost, film.length 
FROM film
WHERE (replacement_cost = 9.99
	OR replacement_cost = 10.99)
	AND film.length >= 60;


/*
7. Select film_id, title, replacement_cost, and rental_rate for films that cost $20 or more to replace and the cost to rent is less than a dollar. (2 points)
*/
SELECT film_id, title, replacement_cost, rental_rate 
FROM film
WHERE replacement_cost >= 20.00
	AND rental_rate < 1.00;

/*
8. Select film_id, title, and rating for films that do not have a G, PG, and PG-13 rating.  Do not use the OR logical operator. (2 points)
*/
SELECT film_id, title, rating 
FROM film
WHERE rating NOT IN ('G', 'PG', 'PG-13');

/*
9. How many films can be rented for 5 to 7 days? Your query should only return 1 row. (2 points)
*/
SELECT COUNT(*)
FROM film
WHERE rental_duration >= 5
	AND rental_duration <= 7;

/*
10. INSERT your favorite movie into the film table. You can arbitrarily set the column values as long as they are related to the column. Only assign values to columns that are not automatically handled by MySQL. (2 points)
*/
INSERT INTO `film`
(title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, `length`, replacement_cost, rating, special_features)
VALUES
('Blade Runner', 'Sci-Fi Noir', '1980', 1, 1, 5, 0.99, 120, 20.99, 'R', 'Deleted Scenes');

SELECT * 
FROM film; -- Insert Confirmed

-- check for autoincremented columns
DESCRIBE film;
/*
11. INSERT your two favorite actors/actresses into the actor table with a single SQL statement. (2 points)
*/
DESCRIBE actor;

INSERT INTO actor 
(first_name, last_name)
VALUES 
('JACK', 'NICHOLSON'),
('CHRISTIAN', 'BALE');

-- Confirmed Insert
SELECT *
FROM actor;


/*
12. The address2 column in the address table inconsistently defines what it means to not have an address2 associated with an address. UPDATE the address2 column to an empty string where the address2 value is currently null. (2 points)
*/

UPDATE address
SET address2 = ''
WHERE address2 IS NULL;

-- Update Confirmation
SELECT *
FROM address;

/*
13. For rated G films less than an hour long, update the special_features column to replace Commentaries with Audio Commentary. Be sure the other special features are not removed. (2 points)
*/

UPDATE `film`
SET special_features = REPLACE(special_features, 'Commentaries', ' Audio Commentary')
WHERE rating = 'G'
	AND `length` < 60;

-- Replacement Successful
SELECT * 
FROM film
WHERE rating = 'G'
	AND `length` < 60;

/*
14. Create a new database named LinkedIn. You will still need to use  LMU.build to create the database. (1 point)
*/

CREATE DATABASE LinkedIn;

-- confirming Addition
SHOW DATABASES;

/*
15. Create a user table to store LinkedIn users. The table must include 5 columns minimum with the appropriate data type and a primary key. 
One of the columns should be Email and must be a unique value. (3 points)
*/

CREATE TABLE user (
	user_id INT(11) NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	user_handle VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	user_type VARCHAR(255) DEFAULT 'standard',
	created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (user_id),
	UNIQUE KEY (email)
) ENGINE=InnoDB;

-- Confirming Table Insert
SHOW TABLES; 

/*
16. Create a table to store a user's work experience. The table must include a primary key, a foreign key column to the user table,
 and have at least 5 columns with the appropriate data type. (3 points)
*/

CREATE TABLE work_experience (
	work_experience_id INT(11) NOT NULL AUTO_INCREMENT,
	work_experience VARCHAR(255) NOT NULL,
	user_id INT(11) NOT NULL,
	work_industry VARCHAR(255) NOT NULL,
	job_title VARCHAR(255) NOT NULL,
	company_name VARCHAR(255) NOT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (work_experience_id),
	CONSTRAINT fk_work_experience_user_user_id FOREIGN KEY (user_id)
REFERENCES user(user_id)
) ENGINE=InnoDB;

-- Confirming Table Input
SHOW TABLES;

/*
17. INSERT 1 user into the user table. (2 points)
*/

INSERT INTO `user`
(first_name, last_name, user_handle, email, user_type)
VALUES
('Jack', 'Williams', '@JWAccounting', 'J.Wiliams@company.com', 'standard')

-- Confirming Insert
SELECT *
FROM `user`;

/*
18. INSERT 1 work experience entry for the user just inserted. (2 points)
*/

INSERT INTO `work_experience`
(work_experience, user_id, work_industry, job_title, company_name)
VALUES
('Management & Consulting', 1, 'Accounting', 'Consulting Partner', 'JWAccounting')

-- Confirming Insert
SELECT *
FROM `work_experience`;

-- SpecialtyFood Database

/*
19. The warehouse manager wants to know all of the products the company carries. Generate a list of all the products with all of the columns. (1 point)
*/

SELECT * 
FROM Products;

/*
20. The marketing department wants to run a direct mail marketing campaign to its American, Canadian, and Mexican customers.
 Write a query to gather the data needed for a mailing label. (2 points)
*/

-- CustomerID for internal use
SELECT CustomerID, CompanyName, ContactName, Address, City, Region, PostalCode, Country
FROM Customers
WHERE Country IN ('USA', 'Mexico', 'Canada')
ORDER BY Country;


/*
21. HR wants to celebrate hire date anniversaries for the sales representatives in the USA office.
 Develop a query that would give HR the information they need to coordinate hire date anniversary gifts.
  Sort the data as you see best fit. (2 points)
*/

SELECT EmployeeID, LastName, 
	FirstName, TitleOfCourtesy,
	HireDate, Country 
FROM Employees
WHERE Country = 'USA'
ORDER BY HireDate ;

/*
22. What is the SQL command to show the structure for the Shippers table? (1 point)
*/

DESCRIBE Shippers;

/*
23. Customer service noticed an increase in shipping errors for orders handled by the employee, Janet Leverling.
 Return the OrderIDs handled by Janet so that the orders can be inspected for other errors. (2 points)

Employees
	EmployeeID
Orders
*/

SELECT OrderID, Employees.EmployeeID, LastName, FirstName
FROM Employees
JOIN Orders
	ON Employees.EmployeeID = Orders.EmployeeID 
WHERE Employees.EmployeeID = 3;

/*
24. The sales team wants to develop stronger supply chain relationships with its suppliers
 by reaching out to the managers who have the decision making power to create a just-in-time inventory arrangement.
  Display the supplier's company name, contact name, title, and phone number for suppliers who have manager or mgr in their title. (2 points)
*/

SELECT CompanyName, ContactName, ContactTitle, Phone 
FROM Suppliers
WHERE ContactTitle LIKE '%Manager%'
	OR ContactTitle LIKE '%mgr%';

/*
25. The warehouse packers want to label breakable products with a fragile sticker.
 Identify the products with glasses, jars, or bottles and are not discontinued (0 = not discontinued). (2 points)
*/

SELECT ProductID, ProductName, QuantityPerUnit, Discontinued 
FROM Products
WHERE (QuantityPerUnit LIKE '%bottles%'
	OR QuantityPerUnit LIKE '%glasses%'
	OR QuantityPerUnit LIKE '%jars%')
	AND Discontinued = 0;

/*
26. How many customers are from Brazil and have a role in sales? Your query should only return 1 row. (2 points)
*/

SELECT COUNT(*) 
FROM Customers
WHERE Country = 'Brazil'
	AND ContactTitle LIKE '%Sales%';

/*
27. Who is the oldest employee in terms of age? Your query should only return 1 row. (2 points)

*/

SELECT 
	EmployeeID,
	LastName,
	FirstName,
	BirthDate,
	YEAR(CURDATE()) - YEAR(BirthDate) AS AgeYears
FROM Employees
ORDER BY BirthDate
LIMIT 1;

/*
28. Calculate the total order price per order and product before and after the discount.
 The products listed should only be for those where a discount was applied.
  Alias the before discount and after discount expressions. (3 points)

*/

SELECT * FROM OrderDetails;
 -- total price per product test calculations

SELECT 
	OrderID,
	ProductID,
	(SUM(UnitPrice * Quantity)) AS OrderPricePreDiscount,
	(SUM((UnitPrice * Quantity * (1 - Discount)))) AS OrderPricePostDiscount,
	(UnitPrice * Quantity) AS TotalPricePerProductPreDiscount,
	(UnitPrice * Quantity * (1 - Discount)) AS TotalPricePerProductPostDiscount
FROM OrderDetails
WHERE Discount != 0 
GROUP BY 
	OrderID;


/*
29. To assist in determining the company's assets, find the total dollar value for all products in stock.
 Your query should only return 1 row.  (2 points)
*/

SELECT SUM(UnitPrice * UnitsInStock) AS DollarValueOfStock
FROM Products;

/*
30. Supplier deliveries are confirmed via email and fax.
 Create a list of suppliers with a missing fax number to help the warehouse receiving team identify
  who to contact to fill in the missing information. (2 points)
*/

SELECT *
FROM Suppliers
WHERE Fax IS NULL;

/*
31. The PR team wants to promote the company's global presence on the website.
 Identify a unique and sorted list of countries where the company has customers. (2 points)
*/

SELECT DISTINCT(Country)
FROM Customers
ORDER BY Country;

/*
32. List the products that need to be reordered from the supplier.
 Know that you can use column names on the right-hand side of a comparison operator.
  Disregard the UnitsOnOrder column. (2 points)
*/

SELECT 
	ProductID,
	ProductName,
	SupplierID,
	CategoryID,
	UnitsInStock,
	ReorderLevel,
	Discontinued 
FROM Products
WHERE Discontinued != 1
	AND UnitsInStock < ReorderLevel;


/*
33. You're the newest hire. INSERT yourself as an employee with the INSERT … SET method.
 You can arbitrarily set the column values as long as they are related to the column. 
 Only assign values to columns that are not automatically handled by MySQL. (2 points)
*/

INSERT INTO Employees 
SET
	LastName = 'Bunikiewicz',
	FirstName = 'Kiejstut',
	Title = 'Business Analyst',
	TitleOfCourtesy = 'Mr.',
	ReportsTo = 2,
	Notes = 'BA in Marketing',
	Extension = '1144',
	PhotoPath = 'http://accweb/emmployees/davolio.bmp',
	Region = 'CA',
	City = 'Los Angeles',
	PostalCode = '90045',
	HomePhone = '555-555-5555',
	Address = '123 XYZ Ave',
	Country = 'USA',
	HireDate = '2021-02-16 00:00:00',
	BirthDate = '1998-01-17 00:00:00';
	

-- Confirming Insert, Successful
SELECT *
FROM Employees;

/*
34. The supplier, Bigfoot Breweries, recently launched their website. UPDATE their website to bigfootbreweries.com. (2 points)
*/


UPDATE Suppliers 
SET HomePage = 'bigfootbreweries.com'
WHERE CompanyName = 'Bigfoot Breweries';

SELECT *
FROM Suppliers
WHERE CompanyName = 'Bigfoot Breweries'; -- Update Confirmed

/*
35. The images on the employee profiles are broken.
 The link to the employee headshot is missing the .com domain extension.
  Fix the PhotoPath link so that the domain properly resolves. Broken link example: http://accweb/emmployees/buchanan.bmp (2 points)

-- Putting .com after 'accweb' ADD WHERE LINE
*/

UPDATE Employees
SET PhotoPath = CONCAT
	(
	LEFT(PhotoPath, 13),
	'.com',
	SUBSTRING(PhotoPath, 14)
	)
WHERE PhotoPath LIKE '%accweb/%';

-- Update confirmed
SELECT EmployeeID, PhotoPath 
FROM Employees;

-- Custom Data Requests
-- Using SpecialtyFood Database

/*
Data Request 1
Question: Which employees/ sales reps have below average sales for the most recent year (2016)?
Business Justification : This query will allow managers to see which sales employees are struggling. This can make managers aware of salespeople who
may need advising from higher performers to improve overall performance. This can also help managers make personnel changes, if necessary.
1. Find Appropriate Tables
2. Find Foreign Keys
3. Calculate total sales by year
4. Create View using Joins
Employees
	EmployeeID
Orders
	OrderID
OrderDetails
5. Query from view to get average
6. Select for sales totals from 2016 by employee
7. Nest average subquery in sales totals 2016
8. Choose employees who have totals below average
9. clean up formatting
*/

CREATE OR REPLACE VIEW AnnualOrderTotals AS
	SELECT
		e.EmployeeID,
		LastName,
		FirstName,
		YEAR(OrderDate) AS OrderYear,
		SUM((UnitPrice * Quantity) * (1 - Discount)) AS TotalSales
	FROM Employees e
	JOIN Orders o 
		ON e.EmployeeID = o.EmployeeID 
	JOIN OrderDetails od 
		ON o.OrderID = od.OrderID 
	GROUP BY e.EmployeeID,
			YEAR(OrderDate);

SELECT
	EmployeeID,
	LastName,
	FirstName,
	OrderYear,
	FORMAT(TotalSales, 2) AS TotalSales,
	FORMAT((
	SELECT 
		AVG(TotalSales)
	FROM AnnualOrderTotals
	WHERE OrderYear = '2016'
	GROUP BY OrderYear
	), 2) AS AverageSalesTotal 
FROM AnnualOrderTotals
WHERE OrderYear = '2016'
HAVING TotalSales < AverageSalesTotal
ORDER BY TotalSales DESC;


/* 
Data Request 2 
Question: Which categories have the slowest order to ship time? 
Business Justification: This could be helpful for managers who are interested in finding package fulfillment bottlenecks.
The managers can easily identify which types of products take longer to ship. This means managers can search for solutions to the
bottleneck and can give customers appropriate waiting estimates based on product ordered.
This request may also show logistics managers that the types of goods being shipped may not have as large of an effect on fulfillment
time as other factors. Interestingly, the results of the request show us that the cateogry of item ordered does not seem to have a big effect on 
fulfillment time.

1. Find tables
2. Find Foreign Keys
3. Average the fulfillment time (time to ship)
4. Group on Category and order by time to ship
Category
	CategoryID
Products
	ProductID
OrderDetails
	OrderID
Orders
*/

SELECT
	c.CategoryID,
	CategoryName,
	AVG(DATEDIFF(ShippedDate, OrderDate)) AS TypicalDaysToShip
FROM Categories c
JOIN Products p
	ON c.CategoryID = p.CategoryID 
JOIN OrderDetails od 
	ON p.ProductID = od.ProductID 
JOIN Orders o 
	ON od.OrderID = o.OrderID 
GROUP BY c.CategoryID 
ORDER BY TypicalDaysToShip DESC;


/*
Data Request 3 
Question: Which employees have a higher than average customer count in 2016?

Business Justification:
This request will allow managers to understand which of their employees may be overbooked by the number of customers they serve. 
This request may also help managers understand why certain employees have higher sales amounts if they are serving more clients.
With this information, a manager may choose to shift customers to one of the other salespeople or to make a team change if a salesperson
is on this list, yet is underperforming.
Interestingly, we see that Laura Callahan is on both this list and on the request list for request 1. This means that she serves a higher than
average amount of customers, yet has a lower than average sales dollars amount which may mean her dollar amount per sales is less than other 
reps.
1. Find Appropriate Tables
2. Find Foreign Keys
Employees
	EmployeeID
Orders
	CustomerID
Customers
3.Create view by joining tables.
4. Separate customer count by year and employee ID
5. Query table to only get employees with a less than average customer count.
6. Have average customer count as column for comparison
*/
CREATE VIEW CustCountAnnual AS
	SELECT
		e.EmployeeID,
		FirstName,
		LastName,
		YEAR(OrderDate) AS CustYear,
		COUNT(c.CustomerID) AS NumberOfCust
	FROM Employees e 
	JOIN Orders o 
		ON e.EmployeeID = o.EmployeeID 
	JOIN Customers c 
		ON o.CustomerID = c.CustomerID 
	GROUP BY e.EmployeeID,
		CustYear;

SELECT 
	EmployeeID,
	LastName,
	FirstName,
	CustYear,
	NumberOfCust,
	(SELECT
		AVG(NumberOfCust)
	FROM CustCountAnnual 
	WHERE CustYear = '2016'
	)AS AverageCustCount
FROM CustCountAnnual
WHERE CustYear = '2016'
GROUP BY EmployeeID
HAVING NumberOfCust > AverageCustCount 
ORDER BY NumberOfCust DESC;


/*
Data Request 4  
Question: How many orders come from each Country, how many orders are shipped to each country, and what are the top 5 revenue generating countries for 2016?
Business Justification: This request will allow managers to understand which centers receive the most orders and which countries are the largest revenue
centers. This request can allow marketing managers to target these countries or similar businesses in these countries
 for business expansion or marketing campaigns. This request can also help the operations managers understand the typical shipping demands for orders.
 
 Although the top 2 countries are also the largest by volume ordered, it is interesting that
  Austria has a high revenue generation for a relatively low number of packages.
Also, Brazil has ordered 50% more packages than Austria, yet generates less revenue.
  
 1. Select Appropriate Tables
 2. Select Foreign Keys
 Customers
 	CustomerID
 Orders
 	OrderID
 OrderDetails
 3. Join tables
 4. Calculate revenue earned and numbers of packages ordered and received
 5. Keep only 2016 data and group by year
 6. Order by revenue Descending
 7. Format revenue and keep top 5
 
*/
SELECT 
	c.Country,
	COUNT(c.Country) AS PackagesOrdered,
	COUNT(ShipCountry) AS PackagesReceived,
	FORMAT(SUM(((Quantity * UnitPrice) * (1 - Discount))), 2) AS RevenuePerCountry
FROM Customers c
JOIN Orders o 
	ON c.CustomerID = o.CustomerID
JOIN OrderDetails od 
	ON o.OrderID = od.OrderID 
WHERE YEAR(OrderDate) = '2016'
GROUP BY c.Country
ORDER BY SUM(((Quantity * UnitPrice) * (1 - Discount))) DESC
LIMIT 5;

/*
Data Request 5 
Question: How does order to shipping time vary based on number of items in the order?

Business Justification: In a similar vein to request 2, this request will allow operations managers to check if the factor that causes longer
fulfillment times is the number of products in an order rather than the types of items being shipped. This can help 
sales and logistics managers effectively estimate how long fulfillment will take, based on the number of items being
shipped in an order. The results of the request show that the largest and smalles orders take longest to fulfill.
The delay for the largest may be caused by number of items, while the delay for the smallest may be caused by prioritization.

1. Identify tables.
2. Identify foreign keys.
3. Find the date diff to get order fulfillment time.
4. Count repetitions of order id as number of items.
5. Join tables to create view for fulfilltime and number of items.
6. Get average fulfillment time (order to ship) grouped by number of items.

OrderDetails
	OrderId
Orders
*/

CREATE OR REPLACE VIEW FulfillmentProducts AS
	SELECT
		o.OrderID,
		DATEDIFF(ShippedDate, OrderDate) AS FulFillTime,
		COUNT(o.OrderID) AS NumberOfItems
	FROM OrderDetails od
	JOIN Orders o 
		ON od.OrderID = o.OrderID
	GROUP BY o.OrderID;

SELECT 
	NumberOfItems,
	AVG(FulFillTime) AS AverageFulfillmentDays
FROM FulfillmentProducts 
WHERE FulFillTime IS NOT NULL
GROUP BY NumberOfItems
ORDER BY AverageFulfillmentDays DESC;

/*
Data Request 6
Question: What are the count of orders handled by each shipper per year and the dollar value of shipped items?

Business Justification
This query can be useful for a manager who wants to renew contracts with the business' shippers. The manager can prepare a more appropriate offer to the
 shipper if the manager has a good picture of the volume and value of packages transported by each shipper.This query will allow the managers to understand
how much revenue in dollars is handled by each shipper as well as the annual revenue and package volume trends for the shippers. This will allow managers
to understand whether the business relationship is weakening over time, or if the business has started to rely too much on a single shipper.

Although Speedy Express was the largest shipper in 2014, it was surpassed by our current largest shipper, United Package.
All values and volumes dropped in 2016 because the year is not yet finished.

1. Identify appropriate tables.
2. Identify foreign keys.
Shippers
	ShipperID/ShipVia
Orders
	OrderID
OrderDetails
3. CREATE VIEW by Joining tables.
4. Aggregate count of orders and revenue in the view
5. Group by Year in the Query.
6. Self Join to pivot the data, so the data is organized by year.
*/

CREATE OR REPLACE VIEW ShipperRevAnnual AS 
	SELECT 
		ShipperID,
		CompanyName,
		Phone,
		YEAR(OrderDate) AS OrderYear,
		COUNT(DISTINCT(o.OrderID)) AS NumberOfOrders,
		SUM(((Quantity * UnitPrice) * (1 - Discount))) AS TotalRevenueShipped
	FROM Shippers s 
	JOIN Orders o 
		ON s.ShipperID = o.ShipVia 
	JOIN OrderDetails od 
		ON o.OrderID = od.OrderID
	GROUP BY
		ShipperID,
		OrderYear;

SELECT
	Y2014.ShipperID,
	Y2014.CompanyName,
	Y2014.OrderYear AS Y2014,
	FORMAT(Y2014.TotalRevenueShipped, 2) AS Y2014Rev,
	Y2014.NumberOfOrders AS Y2014Orders,
	Y2015.OrderYear AS Y2015,
	FORMAT(Y2015.TotalRevenueShipped, 2) AS Y2015Rev,
	Y2015.NumberOfOrders AS Y2015Orders,
	Y2016.OrderYear AS Y2016,
	FORMAT(Y2016.TotalRevenueShipped, 2) AS Y2016Rev,
	Y2016.NumberOfOrders AS Y2016Orders
FROM ShipperRevAnnual Y2014
JOIN ShipperRevAnnual Y2015
	ON Y2014.CompanyName = Y2015.CompanyName
JOIN ShipperRevAnnual Y2016
	ON Y2015.CompanyName = Y2016.CompanyName
WHERE Y2014.OrderYear = Y2015.OrderYear - 1
	AND Y2015.OrderYear = Y2016.OrderYear - 1;
	