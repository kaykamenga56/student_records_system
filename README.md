# Database Security Prototype 


## Group Members
| Name | Student ID |
| :--- | :--- |
| Katendi Kamenga | 2410432 |
| Racheal Chilufya | 2410503 |
## Problem 
Educational institutions store sensitive student data such as personal details, grades, and administrative records that are frequent targets for unauthorized access and data tampering. Without proper database level controls, a system faces three primary risks:

* **Over-privileged access:** Standard users or lecturers having unrestricted read/write access to tables and columns they do not need.
* **SQL Injection:** Unsanitized user inputs allowing attackers to bypass authentication or manipulate database queries.
* **Lack of accountability:** Unauthorized changes to critical records (such as student marks) going undetected without a reliable audit trail.
Demo database: `student_records` (fictional data, created only for this assignment).

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

