-- 02_users_and_permissions.sql : DB users with different privileges (run as root)
USE student_records;

DROP USER IF EXISTS 'admin_user'@'localhost';
DROP USER IF EXISTS 'lecturer_user'@'localhost';
DROP USER IF EXISTS 'readonly_user'@'localhost';
DROP USER IF EXISTS 'app_user'@'localhost';

CREATE USER 'admin_user'@'localhost'    IDENTIFIED BY 'Admin#2026';
CREATE USER 'lecturer_user'@'localhost' IDENTIFIED BY 'Lect#2026';
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'Read#2026';
CREATE USER 'app_user'@'localhost'      IDENTIFIED BY 'App#2026';

-- Admin: full control of this database only
GRANT ALL PRIVILEGES ON student_records.* TO 'admin_user'@'localhost';

-- Lecturer: read students (but NOT national_id), read/insert/update grades, no delete
GRANT SELECT (student_id, full_name, programme, email) ON student_records.students TO 'lecturer_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON student_records.grades TO 'lecturer_user'@'localhost';

-- Read-only: can only view grades
GRANT SELECT ON student_records.grades TO 'readonly_user'@'localhost';

-- Application account used by the Python app: least privilege
GRANT SELECT ON student_records.students  TO 'app_user'@'localhost';
GRANT SELECT ON student_records.app_users TO 'app_user'@'localhost';

FLUSH PRIVILEGES;
SHOW GRANTS FOR 'lecturer_user'@'localhost';
