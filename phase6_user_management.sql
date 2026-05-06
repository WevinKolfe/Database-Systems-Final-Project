-- ============================================================
-- PHASE 6: User Management and Privileges
-- ============================================================
USE company_db;

-- ──────────────────────────────────────────────────────────────
-- 6A. Create DBA user – AlexSmith (Full Privileges)
-- ──────────────────────────────────────────────────────────────
-- Drop user first if re-running
DROP USER IF EXISTS 'AlexSmith'@'localhost';

CREATE USER 'AlexSmith'@'localhost' IDENTIFIED BY 'DbaSecure@2024';

-- Grant ALL privileges on the entire company_db database
GRANT ALL PRIVILEGES ON company_db.* TO 'AlexSmith'@'localhost' WITH GRANT OPTION;

-- ──────────────────────────────────────────────────────────────
-- 6B. Create Analyst user – JamieLee (Read-Only)
-- ──────────────────────────────────────────────────────────────
DROP USER IF EXISTS 'JamieLee'@'localhost';

CREATE USER 'JamieLee'@'localhost' IDENTIFIED BY 'AnalystRead@2024';

-- Grant SELECT-only on all tables in company_db
GRANT SELECT ON company_db.customers      TO 'JamieLee'@'localhost';
GRANT SELECT ON company_db.employees      TO 'JamieLee'@'localhost';
GRANT SELECT ON company_db.orders         TO 'JamieLee'@'localhost';
GRANT SELECT ON company_db.order_details  TO 'JamieLee'@'localhost';
GRANT SELECT ON company_db.products       TO 'JamieLee'@'localhost';
GRANT SELECT ON company_db.categories     TO 'JamieLee'@'localhost';
GRANT SELECT ON company_db.suppliers      TO 'JamieLee'@'localhost';
GRANT SELECT ON company_db.shippers       TO 'JamieLee'@'localhost';
-- Also grant SELECT on the view
GRANT SELECT ON company_db.vw_employee_sales TO 'JamieLee'@'localhost';

-- Apply privilege changes immediately
FLUSH PRIVILEGES;

-- ──────────────────────────────────────────────────────────────
-- Verify: Show grants for both users
-- ──────────────────────────────────────────────────────────────
SHOW GRANTS FOR 'AlexSmith'@'localhost';
SHOW GRANTS FOR 'JamieLee'@'localhost';

-- ──────────────────────────────────────────────────────────────
-- Example: Revoke a privilege from JamieLee (best-practice demo)
-- ──────────────────────────────────────────────────────────────
-- REVOKE SELECT ON company_db.employees FROM 'JamieLee'@'localhost';
-- FLUSH PRIVILEGES;
