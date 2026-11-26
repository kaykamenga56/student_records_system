-- 03_permission_tests.sql : run each block while connected as the named user
-- (e.g. mysql -u lecturer_user -p student_records). "EXPECTED" shows the result.

-- ===== readonly_user =====
SELECT * FROM grades;                       -- EXPECTED: works
UPDATE grades SET mark = 100 WHERE grade_id = 1;   -- EXPECTED: ERROR 1142 UPDATE command denied
SELECT * FROM students;                     -- EXPECTED: ERROR 1142 SELECT command denied

-- ===== lecturer_user =====
SELECT full_name, programme FROM students;  -- EXPECTED: works
SELECT national_id FROM students;           -- EXPECTED: ERROR 1143 column access denied
UPDATE grades SET mark = 75 WHERE grade_id = 1;    -- EXPECTED: works
DELETE FROM grades WHERE grade_id = 1;      -- EXPECTED: ERROR 1142 DELETE command denied
DROP TABLE grades;                          -- EXPECTED: ERROR 1142 DROP command denied

-- ===== admin_user =====
SELECT * FROM students;                     -- EXPECTED: works (incl. national_id)
DELETE FROM grades WHERE grade_id = 4;      -- EXPECTED: works
