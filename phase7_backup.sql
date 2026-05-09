-- ============================================================
-- PHASE 7: Database Backup
-- ============================================================

-- ──────────────────────────────────────────────────────────────
-- Command-Line Alternative (mysqldump)
-- Run the following in your Terminal / Command Prompt:
-- ──────────────────────────────────────────────────────────────
--
--   mysqldump -u root -p company_db > company_db_backup.sql
--
-- To include routines (stored procedures) and triggers:
--
--   mysqldump -u root -p --routines --triggers company_db > company_db_backup.sql
--
-- ──────────────────────────────────────────────────────────────
-- Restore (if needed):
-- ──────────────────────────────────────────────────────────────
--
--   mysql -u root -p < company_db_backup.sql
--
-- ──────────────────────────────────────────────────────────────
-- Verify what's in your database before backing up:
-- ──────────────────────────────────────────────────────────────

USE company_db;

SHOW TABLES;

SELECT TABLE_NAME, TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'company_db';

-- Check stored routines
SELECT ROUTINE_NAME, ROUTINE_TYPE
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'company_db';

-- Check triggers
SELECT TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'company_db';
