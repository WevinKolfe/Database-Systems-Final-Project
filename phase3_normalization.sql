-- ============================================================
-- PHASE 3: Normalization using CTAS (CREATE TABLE AS SELECT)
-- ============================================================
USE company_db;

-- ── 1. CUSTOMERS ─────────────────────────────────────────────
CREATE TABLE customers AS
SELECT DISTINCT
    customerID,
    companyName,
    contactName,
    contactTitle
FROM raw_orders;

-- ── 2. EMPLOYEES ─────────────────────────────────────────────
CREATE TABLE employees AS
SELECT DISTINCT
    employeeID,
    empLastName   AS lastName,
    empFirstName  AS firstName,
    empTitle      AS title
FROM raw_orders;

-- ── 3. CATEGORIES ────────────────────────────────────────────
CREATE TABLE categories AS
SELECT DISTINCT
    categoryID,
    categoryName
FROM raw_orders;

-- ── 4. SUPPLIERS ─────────────────────────────────────────────
CREATE TABLE suppliers AS
SELECT DISTINCT
    supplierID,
    suppCompanyName  AS companyName,
    suppContactName  AS contactName,
    suppContactTitle AS contactTitle
FROM raw_orders;

-- ── 5. PRODUCTS ──────────────────────────────────────────────
CREATE TABLE products AS
SELECT DISTINCT
    productID,
    productName,
    supplierID,
    categoryID,
    quantityPerUnit,
    productUnitPrice AS unitPrice,
    unitsInStock,
    unitsOnOrder,
    reorderLevel,
    discontinued
FROM raw_orders;

-- ── 6. SHIPPERS (shipVia) ────────────────────────────────────
-- The raw data only has shipVia ID; no shipper name in the dataset.
-- We create the table with the IDs that exist.
CREATE TABLE shippers AS
SELECT DISTINCT
    shipVia AS shipperID
FROM raw_orders;

-- ── 7. ORDERS ────────────────────────────────────────────────
CREATE TABLE orders AS
SELECT DISTINCT
    orderID,
    customerID,
    employeeID,
    orderDate,
    requiredDate,
    shippedDate,
    shipVia,
    Freight
FROM raw_orders;

-- ── 8. ORDER_DETAILS ─────────────────────────────────────────
CREATE TABLE order_details AS
SELECT
    orderID,
    productID,
    unitPrice,
    quantity,
    discount
FROM raw_orders;

-- Verify row counts
SELECT 'customers' as 'Table',          COUNT(*) AS numRows FROM customers    UNION ALL
SELECT 'employees',          COUNT(*) FROM employees   UNION ALL
SELECT 'categories',         COUNT(*) FROM categories  UNION ALL
SELECT 'suppliers',          COUNT(*) FROM suppliers   UNION ALL
SELECT 'products',           COUNT(*) FROM products    UNION ALL
SELECT 'shippers',           COUNT(*) FROM shippers    UNION ALL
SELECT 'orders',             COUNT(*) FROM orders      UNION ALL
SELECT 'order_details',      COUNT(*) FROM order_details;
