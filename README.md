# Database Security Prototype 
# Database Security Prototype

# Database Security Prototype

## Group Members
| Name | Student ID |
| :--- | :--- |
| Katendi Kamenga | 2410432 |
| Racheal Chilufya | 2410503 |

Demo database: `student_records` (fictional data, created only for this assignment).

Demo database: `student_records` (fictional data, created only for this assignment).

Demo database: `student\_records` (fictional data, created only for this assignment).

## Setup

1. Install MySQL Server + Workbench, and Python 3 with `pip install mysql-connector-python`.
2. In Workbench (as root) run, in order:
`01\_schema\_and\_data.sql`, `02\_users\_and\_permissions.sql`, `04\_audit\_log.sql`
3. Permission demo: connect as each user and run the matching block in `03\_permission\_tests.sql`.
4. Injection demo: `python app\_demo.py`
5. Audit demo: as `lecturer\_user` run `UPDATE grades SET mark = 90 WHERE grade\_id = 2;`
then as `admin\_user` run `SELECT \* FROM audit\_log;`

## Security measures shown

Authentication (separate DB accounts, hashed app passwords) · Access control (GRANT, column-level
privileges, least privilege) · Parameterised queries · Audit log (triggers)

