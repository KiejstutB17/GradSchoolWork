/*
Host: lmu-dev-01.cx4mhnf6awhd.us-east-1.rds.amazonaws.com
Username: admin
Password: sql_2021
*/

-- Create a database named lesson_exercises_04
CREATE DATABASE lesson_exercises_04;

-- List the databases
SHOW DATABASES;

-- Make the lesson_exercises_04 database the active database
USE lesson_exercises_04;

-- Create a customer table with a primary key and the following columns:
-- first_name, last_name, email
CREATE TABLE customer (
	customer_id INT(11) NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	email VARCHAR(255),
	PRIMARY KEY (customer_id)
);

-- List the tables in the active database
SHOW TABLES;

-- Display the customer table schema
DESCRIBE customer;

-- Insert one record into the customer table
INSERT INTO customer
SET 
	first_name = 'Kiejstut',
	last_name = 'Bunikiewicz',
	email = 'kbuniki1@lion.lmu.edu';

-- Confirm the insert by selecting all rows and columns from the customer table
SELECT *
FROM customer;
