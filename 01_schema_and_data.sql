-- 01_schema_and_data.sql : database, tables, sample data (all fictional)
DROP DATABASE IF EXISTS student_records;
CREATE DATABASE student_records;
USE student_records;

CREATE TABLE students (
  student_id   INT AUTO_INCREMENT PRIMARY KEY,
  full_name    VARCHAR(100) NOT NULL,
  programme    VARCHAR(100) NOT NULL,
  email        VARCHAR(100) NOT NULL,
  national_id  VARCHAR(20)  NOT NULL      -- sensitive column
);

CREATE TABLE grades (
  grade_id   INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  course     VARCHAR(20) NOT NULL,
  mark       INT NOT NULL CHECK (mark BETWEEN 0 AND 100),
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Application login table (passwords stored as SHA-256 hashes, never plain text)
CREATE TABLE app_users (
  username      VARCHAR(50) PRIMARY KEY,
  password_hash CHAR(64) NOT NULL,
  role          VARCHAR(20) NOT NULL
);

INSERT INTO students (full_name, programme, email, national_id) VALUES
 ('Mwansa Banda',   'BIT', 'mwansa@example.com',  '100001/10/1'),
 ('Chanda Phiri',   'BIT', 'chanda@example.com',  '100002/10/1'),
 ('Natasha Mulenga','BCS', 'natasha@example.com', '100003/10/1'),
 ('Joseph Tembo',   'BCS', 'joseph@example.com',  '100004/10/1');

INSERT INTO grades (student_id, course, mark) VALUES
 (1,'BIT3360',72),(2,'BIT3360',65),(3,'BIT3360',81),(4,'BIT3360',58);

-- passwords: admin123 / lecturer123  (sample only)
INSERT INTO app_users VALUES
 ('admin',    SHA2('admin123',256),    'admin'),
 ('lecturer', SHA2('lecturer123',256), 'lecturer');
