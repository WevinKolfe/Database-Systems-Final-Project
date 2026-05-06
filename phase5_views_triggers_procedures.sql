-- ============================================================
-- PHASE 5: Views, Triggers, and Stored Procedures
-- ============================================================
USE company_db;

-- ──────────────────────────────────────────────────────────────
-- 5A. VIEW – Employee Sales Summary
-- Shows total quantity sold and total revenue per employee
-- ──────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_employee_sales AS
SELECT
    e.employeeID,
    CONCAT(e.firstName, ' ', e.lastName)       AS employeeName,
    e.title,
    COUNT(DISTINCT o.orderID)                  AS totalOrders,
    SUM(od.quantity)                           AS totalQuantitySold,
    ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)), 2) AS totalRevenue
FROM employees    e
JOIN orders       o  ON o.employeeID  = e.employeeID
JOIN order_details od ON od.orderID   = o.orderID
GROUP BY e.employeeID, e.firstName, e.lastName, e.title
ORDER BY totalRevenue DESC;

-- Test the view
SELECT * FROM vw_employee_sales;


-- ──────────────────────────────────────────────────────────────
-- 5B. TRIGGER – Auto-reduce stock on new order_detail insert
-- ──────────────────────────────────────────────────────────────
DELIMITER $$

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE products
    SET unitsInStock = unitsInStock - NEW.quantity
    WHERE productID = NEW.productID;
END$$

DELIMITER ;

-- Test the trigger (optional demo – undo with a DELETE or UPDATE after)
-- INSERT INTO order_details VALUES (99999, 1, 18.00, 5, 0.00);
-- SELECT productID, unitsInStock FROM products WHERE productID = 1;


-- ──────────────────────────────────────────────────────────────
-- 5C. STORED PROCEDURE – Low Stock Alert
-- Returns products whose unitsInStock < given threshold
-- ──────────────────────────────────────────────────────────────
DELIMITER $$

CREATE PROCEDURE sp_low_stock(IN p_threshold INT)
BEGIN
    SELECT
        p.productID,
        p.productName,
        c.categoryName,
        s.companyName  AS supplierName,
        p.unitsInStock,
        p.reorderLevel,
        p.unitsOnOrder
    FROM products  p
    JOIN categories c ON c.categoryID = p.categoryID
    JOIN suppliers  s ON s.supplierID = p.supplierID
    WHERE p.unitsInStock < p_threshold
      AND p.discontinued = 0
    ORDER BY p.unitsInStock ASC;
END$$

DELIMITER ;

-- Test the stored procedure (threshold = 10 units)
CALL sp_low_stock(10);
