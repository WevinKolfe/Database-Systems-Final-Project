-- ============================================================
-- PHASE 4: Table Alterations – PKs, FKs, Constraints
-- ============================================================
USE company_db;

-- ── CUSTOMERS ────────────────────────────────────────────────
ALTER TABLE customers
    MODIFY customerID  VARCHAR(10)  NOT NULL,
    MODIFY companyName VARCHAR(100) NOT NULL,
    ADD PRIMARY KEY (customerID);

-- ── EMPLOYEES ────────────────────────────────────────────────
ALTER TABLE employees
    MODIFY employeeID INT         NOT NULL,
    MODIFY lastName   VARCHAR(50) NOT NULL,
    MODIFY firstName  VARCHAR(50) NOT NULL,
    ADD PRIMARY KEY (employeeID);

-- ── CATEGORIES ───────────────────────────────────────────────
ALTER TABLE categories
    MODIFY categoryID   INT          NOT NULL,
    MODIFY categoryName VARCHAR(100) NOT NULL,
    ADD PRIMARY KEY (categoryID);

-- ── SUPPLIERS ────────────────────────────────────────────────
ALTER TABLE suppliers
    MODIFY supplierID  INT          NOT NULL,
    MODIFY companyName VARCHAR(100) NOT NULL,
    ADD PRIMARY KEY (supplierID);

-- ── SHIPPERS ─────────────────────────────────────────────────
ALTER TABLE shippers
    MODIFY shipperID INT NOT NULL,
    ADD PRIMARY KEY (shipperID);

-- ── PRODUCTS ─────────────────────────────────────────────────
ALTER TABLE products
    MODIFY productID       INT           NOT NULL,
    MODIFY productName     VARCHAR(100)  NOT NULL,
    MODIFY unitPrice       DECIMAL(10,2) NOT NULL,
    MODIFY unitsInStock    INT           NOT NULL DEFAULT 0,
    MODIFY unitsOnOrder    INT           NOT NULL DEFAULT 0,
    MODIFY reorderLevel    INT           NOT NULL DEFAULT 0,
    MODIFY discontinued    TINYINT(1)    NOT NULL DEFAULT 0,
    ADD PRIMARY KEY (productID),
    ADD CONSTRAINT fk_product_supplier FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID),
    ADD CONSTRAINT fk_product_category FOREIGN KEY (categoryID) REFERENCES categories(categoryID);

-- ── ORDERS ───────────────────────────────────────────────────
ALTER TABLE orders
    MODIFY orderID     INT            NOT NULL,
    MODIFY customerID  VARCHAR(10)    NOT NULL,
    MODIFY employeeID  INT            NOT NULL,
    MODIFY orderDate   DATE           NOT NULL,
    MODIFY Freight     DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    ADD PRIMARY KEY (orderID),
    ADD CONSTRAINT fk_order_customer FOREIGN KEY (customerID) REFERENCES customers(customerID),
    ADD CONSTRAINT fk_order_employee FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
    ADD CONSTRAINT fk_order_shipper  FOREIGN KEY (shipVia)    REFERENCES shippers(shipperID);

-- ── ORDER_DETAILS ─────────────────────────────────────────────
ALTER TABLE order_details
    MODIFY orderID   INT           NOT NULL,
    MODIFY productID INT           NOT NULL,
    MODIFY unitPrice DECIMAL(10,2) NOT NULL,
    MODIFY quantity  INT           NOT NULL,
    MODIFY discount  DECIMAL(6,4)  NOT NULL DEFAULT 0,
    ADD PRIMARY KEY (orderID, productID),
    ADD CONSTRAINT fk_od_order   FOREIGN KEY (orderID)   REFERENCES orders(orderID),
    ADD CONSTRAINT fk_od_product FOREIGN KEY (productID) REFERENCES products(productID);

-- Verify constraints
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'company_db'
ORDER BY TABLE_NAME;
