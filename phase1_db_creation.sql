-- ============================================================
-- PHASE 1: Database Creation & Data Loading
-- ============================================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

-- Step 2: Create the raw/staging table (all 31 columns from CSV)
DROP TABLE IF EXISTS raw_orders;

CREATE TABLE raw_orders (
    orderID         INT,
    customerID      VARCHAR(10),
    employeeID      INT,
    orderDate       DATE,
    requiredDate    DATE,
    shippedDate     DATE,
    shipVia         INT,
    Freight         DECIMAL(10,2),
    productID       INT,
    unitPrice       DECIMAL(10,2),
    quantity        INT,
    discount        DECIMAL(6,4),
    companyName     VARCHAR(100),
    contactName     VARCHAR(100),
    contactTitle    VARCHAR(100),
    empLastName     VARCHAR(50),
    empFirstName    VARCHAR(50),
    empTitle        VARCHAR(100),
    productName     VARCHAR(100),
    supplierID      INT,
    categoryID      INT,
    quantityPerUnit VARCHAR(50),
    productUnitPrice DECIMAL(10,2),
    unitsInStock    INT,
    unitsOnOrder    INT,
    reorderLevel    INT,
    discontinued    TINYINT(1),
    categoryName    VARCHAR(100),
    suppCompanyName VARCHAR(100),
    suppContactName VARCHAR(100),
    suppContactTitle VARCHAR(100)
);

-- Step 3: Load the cleaned CSV into the staging table
--   ** Update the file path below to match your local path **
LOAD DATA INFILE '/Users/krish/Desktop/files/company_data_clean.csv'
INTO TABLE raw_orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(orderID, customerID, employeeID,
 orderDate, requiredDate, shippedDate,
 shipVia, Freight, productID, unitPrice, quantity, discount,
 companyName, contactName, contactTitle,
 empLastName, empFirstName, empTitle,
 productName, supplierID, categoryID, quantityPerUnit,
 productUnitPrice, unitsInStock, unitsOnOrder, reorderLevel, discontinued,
 categoryName, suppCompanyName, suppContactName, suppContactTitle);

-- Verify the load
SELECT COUNT(*) AS total_rows FROM raw_orders;
SELECT * FROM raw_orders LIMIT 5;
