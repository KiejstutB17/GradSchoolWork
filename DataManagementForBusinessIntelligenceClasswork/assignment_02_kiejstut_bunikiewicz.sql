/*
AWS RDS Database Connection Details
Host: lmu-dev-01.cx4mhnf6awhd.us-east-1.rds.amazonaws.com
Username: admin
Password: sql_2021
*/

-- 2. Create the dimension and fact tables in a new database named dw_dillards on your RDS MySQL instance
-- Creating DIM_SKU Table
CREATE TABLE DIM_SKU (
	SKU INT,
	DEPT INT,
	DEPTDESC VARCHAR(255),
	PRIMARY KEY (SKU)
);

-- Creating DIM_STORE Table
CREATE TABLE DIM_STORE ( 
	STORE INT,
	CITY VARCHAR(255),
	STATE VARCHAR(255),
	ZIP VARCHAR(255),
	PRIMARY KEY (STORE)
);

-- Creating DIM_DATE Table
CREATE TABLE DIM_DATE (
	DATE DATE,
  	YEAR INT,
  	MONTH INT,
  	MONTH_NAME VARCHAR(10),
  	DAY_OF_MONTH INT,
  	DAY_OF_WEEK INT,
  	DAY_OF_WEEK_NAME VARCHAR(10),
  	QUARTER INT,
  	PRIMARY KEY (`DATE`)
 );


-- Creating FACT_SALES Table without foreign keys in order to read in the data on tableau prep
CREATE TABLE FACT_SALES (
	SALEDATE DATE NOT NULL,
	STORE INT NOT NULL,
	SKU INT NOT NULL,
	REVENUE DECIMAL(10,2) NOT NULL DEFAULT 0,
	UNITS_SOLD INT NOT NULL DEFAULT 0,
	PRIMARY KEY (SALEDATE, STORE, SKU)
);


-- Creating FACT_CLONE_SALES Table To Show Fact Table With Foreign Keys
CREATE TABLE FACT_CLONE_SALES (
	SALEDATE DATE NOT NULL,
	STORE INT NOT NULL,
	SKU INT NOT NULL,
	REVENUE DECIMAL(10,2) NOT NULL DEFAULT 0,
	UNITS_SOLD INT NOT NULL DEFAULT 0,
	PRIMARY KEY (SALEDATE, STORE, SKU),
	CONSTRAINT fk_FACT_SALES_DIM_DATE_SALEDATE FOREIGN KEY (SALEDATE) REFERENCES DIM_DATE(`DATE`),
	CONSTRAINT fk_FACT_SALES_DIM_STORE_STORE FOREIGN KEY (STORE) REFERENCES DIM_STORE(STORE),
	CONSTRAINT fk_FACT_SALES_DIM_SKU_SKU FOREIGN KEY (SKU) REFERENCES DIM_SKU(SKU)
);

SELECT COUNT(*)
FROM FACT_SALES;

SELECT *
FROM FACT_SALES
LIMIT 10;
-- 11. Create tables in Athena for each unzipped file using the OpenCSVSerde SERDE
-- departments table
CREATE EXTERNAL TABLE assignment_02_kiejstut_bunikiewicz.departments (
	`DEPT` INT,
	`DEPTDESC` STRING 
) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	'separatorChar' = ','
) 
LOCATION 's3://assignment-02-kiejstut-bunikiewicz/staging/departments' 
TBLPROPERTIES (
	'has_encrypted_data'='false'
);

-- sku table
CREATE EXTERNAL TABLE assignment_02_kiejstut_bunikiewicz.sku (
	`SKU` INT,
	`DEPT` INT,
	`CLASSID` STRING,
	`UPC` STRING,
	`STYLE` STRING,
	`COLOR` STRING,
	`SIZE` STRING,
	`PACKSIZE` INT,
	`VENDOR` STRING,
	`BRAND` STRING
) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	'separatorChar' = ','
) 
LOCATION 's3://assignment-02-kiejstut-bunikiewicz/staging/sku' 
TBLPROPERTIES (
	'has_encrypted_data'='false'
);

-- stores table
CREATE EXTERNAL TABLE assignment_02_kiejstut_bunikiewicz.stores (
	`STORE` INT,
	`CITY` STRING,
	`STATE` STRING,
	`ZIP` STRING
) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	'separatorChar' = ','
) 
LOCATION 's3://assignment-02-kiejstut-bunikiewicz/staging/stores' 
TBLPROPERTIES (
	'has_encrypted_data'='false'
);

-- transactions tables
CREATE EXTERNAL TABLE assignment_02_kiejstut_bunikiewicz.transactions (
  `SKU` INT,
  `STORE` INT,
  `REGISTER` INT,
  `TRANNUM` STRING,
  `INTERID` STRING,
  `SALEDATE` STRING,
  `STYPE` STRING,
  `QUANTITY` INT,
  `ORGPRICE` STRING,
  `SPRICE` STRING,
  `AMT` STRING,
  `SEQ` STRING,
  `MIC` STRING
)
PARTITIONED BY (
	`MONTH` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	'separatorChar' = ',',
	'quoteChar'     = '\"'
) 
LOCATION 's3://assignment-02-kiejstut-bunikiewicz/staging/transactions' 
TBLPROPERTIES (
	'has_encrypted_data'='false'
);

MSCK REPAIR TABLE assignment_02_kiejstut_bunikiewicz.transactions;



-- 12. Using a CREATE TABLE AS SELECT (CTAS) statement, convert the OpenCSVSerde tables to 
-- a Snappy compressed table in a Parquet columnar storage format
-- Maintain the partitions for the transactions table

-- for departments
CREATE TABLE assignment_02_kiejstut_bunikiewicz.departments_parquet_snappy
WITH (
  format = 'Parquet',
  parquet_compression = 'SNAPPY',
  external_location = 's3://assignment-02-kiejstut-bunikiewicz/staging/departments-parquet-snappy/'
) AS SELECT *
FROM assignment_02_kiejstut_bunikiewicz.departments;

-- for sku
CREATE TABLE assignment_02_kiejstut_bunikiewicz.sku_parquet_snappy
WITH (
  format = 'Parquet',
  parquet_compression = 'SNAPPY',
  external_location = 's3://assignment-02-kiejstut-bunikiewicz/staging/sku-parquet-snappy/'
) AS SELECT *
FROM assignment_02_kiejstut_bunikiewicz.sku;

-- for store
CREATE TABLE assignment_02_kiejstut_bunikiewicz.stores_parquet_snappy
WITH (
  format = 'Parquet',
  parquet_compression = 'SNAPPY',
  external_location = 's3://assignment-02-kiejstut-bunikiewicz/staging/stores-parquet-snappy/'
) AS SELECT *
FROM assignment_02_kiejstut_bunikiewicz.stores;

-- for transaction
CREATE TABLE assignment_02_kiejstut_bunikiewicz.transactions_parquet_snappy
WITH (
  format = 'Parquet',
  parquet_compression = 'SNAPPY',
  partitioned_by = ARRAY['month'],
  external_location = 's3://assignment-02-kiejstut-bunikiewicz/staging/transactions-parquet-snappy/'
) AS SELECT *
FROM assignment_02_kiejstut_bunikiewicz.transactions;


-- 17. Build 3 Tableau dashboards to satisfy the reporting requirements for each 
-- reporting category (Strategic, Operational, Analytical)
-- Write the SQL (6 total) for each report

-- Fact_returns table for exam
CREATE TABLE FACT_RETURNS (
	SALEDATE DATE NOT NULL,
	STORE INT NOT NULL,
	SKU INT NOT NULL,
	AMT DECIMAL(10,2) NOT NULL DEFAULT 0,
	QUANTITY INT NOT NULL DEFAULT 0,
	PRIMARY KEY (SALEDATE, STORE, SKU)
);

SELECT *
FROM FACT_RETURNS
LIMIT 10;

SELECT 
SKU,
SUM(QUANTITY) AS TOTAL_RETURNS_UNITS
FROM FACT_RETURNS
WHERE SALEDATE = '2021-04-26'
GROUP BY SKU
ORDER BY SUM(QUANTITY) DESC;


DROP TABLE dw_dillards.FACT_RETURNS;