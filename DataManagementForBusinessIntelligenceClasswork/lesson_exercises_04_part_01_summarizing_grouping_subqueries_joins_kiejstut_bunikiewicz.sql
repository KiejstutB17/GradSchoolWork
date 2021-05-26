-- 01 - How many orders were booked by employees from the 425 area code?
SELECT COUNT(*)
FROM Orders
WHERE EmployeeID IN
    (
        SELECT EmployeeID
        FROM Employees
        WHERE EmpAreaCode = 425
        );

-- 02 - How many orders were booked by employees from the 425 area code? 
-- Use a JOIN instead of a subquery.
SELECT COUNT(*)
FROM Orders O
JOIN Employees E
    ON O.EmployeeID = E.EmployeeID
WHERE E.EmpAreaCode = 425;

-- 03 - Show me the average number of days to deliver products per vendor name.
-- Filter the results to only show vendors where the 
-- average number of days to deliver is greater than 5.
SELECT VendName, AVG(DaysToDeliver)
FROM Product_Vendors PV
JOIN Vendors V
    ON PV.VendorID = V.VendorID
GROUP BY VendName
HAVING AVG(DaysToDeliver) > 5;

-- Avoid GROUP BY column_#
SELECT VendName, AVG(DaysToDeliver)
FROM Product_Vendors PV
JOIN Vendors V
    ON PV.VendorID = V.VendorID
GROUP BY 1
HAVING AVG(DaysToDeliver) > 5;

-- 04 - Show me the average number of days to deliver products per vendor name 
-- where the average is greater than the average delivery days for all vendors.
SELECT VendName, AVG(DaysToDeliver)
FROM Product_Vendors PV
JOIN Vendors V
    ON PV.VendorID = V.VendorID
GROUP BY VendName
HAVING AVG(DaysToDeliver) >
    (
    SELECT AVG(DaysToDeliver)
    FROM Product_Vendors
    );

SELECT AVG(DaysToDeliver)
FROM Product_Vendors;
-- 05 - Return just the number of vendors where their number of days to deliver 
-- products is greater than the average days to deliver across all vendors.
SELECT COUNT(*) AS num__of_vendors
FROM
 (
    SELECT VendName, AVG(DaysToDeliver)
    FROM Product_Vendors PV
    JOIN Vendors V
     ON PV.VendorID = V.VendorID
    GROUP BY VendName
    HAVING AVG(DaysToDeliver) >
        (
        SELECT AVG(DaysToDeliver)
        FROM Product_Vendors
        )
    
  ) AS vendavg;

-- 06 - How many products are associated to each category name?
-- Alias the aggregate expression
-- Sort the product counts from high to low
SELECT
    CategoryDescription,
    COUNT(*) AS ProductCount
FROM Products
JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryDescription
ORDER BY ProductCount DESC;

-- 07 - List the categories with more than 3 products.
SELECT
    CategoryDescription,
    COUNT(*) AS ProductCount
FROM Products
JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryDescription
HAVING ProductCount > 3
ORDER BY ProductCount DESC;

-- 08 - List the categories with a product count greater than the average.
-- Average based on grouped results and not just a column's value.

-- 08.01 - Select the product counts per category
SELECT
    CategoryDescription,
    COUNT(*) AS ProductCount
FROM Products
JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryDescription
ORDER BY ProductCount DESC;

-- 08.02 - Get average # of products per category
SELECT AVG(ProductCount)
FROM
    (
        SELECT
        CategoryDescription,
        COUNT(*) AS ProductCount
        FROM Products
        JOIN Categories
            ON Products.CategoryID = Categories.CategoryID
        GROUP BY CategoryDescription
        ORDER BY ProductCount DESC
    ) AS ProductCountsByCategory;

-- 08.03 - Add the average # of products per category as a subquery 
-- to the right-hand side of the HAVING comparison operator 
SELECT
    CategoryDescription,
    COUNT(*) AS ProductCount
FROM Products
JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryDescription
HAVING ProductCount >
    (
       SELECT AVG(ProductCount)
        FROM
            (
            SELECT
            CategoryDescription,
            COUNT(*) AS ProductCount
            FROM Products
            JOIN Categories
                ON Products.CategoryID = Categories.CategoryID
            GROUP BY CategoryDescription
            ORDER BY ProductCount DESC
            ) AS ProductCountsByCategory 
    )
ORDER BY ProductCount DESC;

-- 08.04 - Display the average product count alongside the category product count
SELECT
    CategoryDescription,
    COUNT(*) AS ProductCount,
    (
       SELECT AVG(ProductCount)
        FROM
            (
            SELECT
            CategoryDescription,
            COUNT(*) AS ProductCount
            FROM Products
            JOIN Categories
                ON Products.CategoryID = Categories.CategoryID
            GROUP BY CategoryDescription
            ORDER BY ProductCount DESC
            )  AS ProductCountsByCategory
    ) AS AvgProductCount
FROM Products
JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryDescription
HAVING ProductCount >
    (
       SELECT AVG(ProductCount)
        FROM
            (
            SELECT
            CategoryDescription,
            COUNT(*) AS ProductCount
            FROM Products
            JOIN Categories
                ON Products.CategoryID = Categories.CategoryID
            GROUP BY CategoryDescription
            ORDER BY ProductCount DESC
            ) AS ProductCountsByCategory 
    )
ORDER BY ProductCount DESC;

-- 09 - How many categories have more products than the average product count per category?
SELECT COUNT(*) AS CategoryCount
FROM
    (
    SELECT
        CategoryDescription,
        COUNT(*) AS ProductCount
    FROM Products
    JOIN Categories
        ON Products.CategoryID = Categories.CategoryID
    GROUP BY CategoryDescription
    HAVING ProductCount >
        (
            SELECT AVG(ProductCount)
            FROM
                (
                SELECT
                CategoryDescription,
                COUNT(*) AS ProductCount
                FROM Products
                JOIN Categories
                    ON Products.CategoryID = Categories.CategoryID
                GROUP BY CategoryDescription
                ) AS ProductCountsByCategory 
    )
) AS ProductCountGreaterThanAvg;
