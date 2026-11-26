-- 04_audit_log.sql : audit log using triggers (run as root)
USE student_records;

CREATE TABLE IF NOT EXISTS audit_log (
  log_id     INT AUTO_INCREMENT PRIMARY KEY,
  table_name VARCHAR(50),
  action     VARCHAR(10),
  record_id  INT,
  old_value  VARCHAR(255),
  new_value  VARCHAR(255),
  changed_by VARCHAR(100),
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS trg_grades_update;
DROP TRIGGER IF EXISTS trg_grades_delete;
DROP TRIGGER IF EXISTS trg_grades_insert;
DELIMITER //
CREATE TRIGGER trg_grades_insert AFTER INSERT ON grades FOR EACH ROW
BEGIN
  INSERT INTO audit_log (table_name, action, record_id, old_value, new_value, changed_by)
  VALUES ('grades','INSERT',NEW.grade_id,NULL,CONCAT(NEW.course,':',NEW.mark),USER());
END//
CREATE TRIGGER trg_grades_update AFTER UPDATE ON grades FOR EACH ROW
BEGIN
  INSERT INTO audit_log (table_name, action, record_id, old_value, new_value, changed_by)
  VALUES ('grades','UPDATE',NEW.grade_id,CONCAT(OLD.course,':',OLD.mark),CONCAT(NEW.course,':',NEW.mark),USER());
END//
CREATE TRIGGER trg_grades_delete AFTER DELETE ON grades FOR EACH ROW
BEGIN
  INSERT INTO audit_log (table_name, action, record_id, old_value, new_value, changed_by)
  VALUES ('grades','DELETE',OLD.grade_id,CONCAT(OLD.course,':',OLD.mark),NULL,USER());
END//
DELIMITER ;

-- Audit trail should not be editable by lecturers; admin already has full rights.
-- DEMO (as lecturer_user, then admin_user):
--   UPDATE grades SET mark = 90 WHERE grade_id = 2;
--   SELECT * FROM audit_log;     -- shows who changed what, and when
