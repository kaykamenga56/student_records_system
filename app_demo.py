"""app_demo.py - SQL injection vs parameterised queries (student_records demo DB only).
Setup:  pip install mysql-connector-python
Run:    python app_demo.py
"""
import hashlib
import getpass
import mysql.connector

conn = mysql.connector.connect(
    host="localhost", user="app_user", password="App#2026", database="student_records"
)
cur = conn.cursor()


def sha256(text):
    return hashlib.sha256(text.encode()).hexdigest()


def login_vulnerable(username, password):
    # BAD: user input is pasted straight into the SQL string.
    query = (f"SELECT username, role FROM app_users WHERE username = '{username}' "
             f"AND password_hash = '{sha256(password)}'")
    print("  SQL sent:", query)
    cur.execute(query)
    return cur.fetchone()


def login_safe(username, password):
    # GOOD: placeholders (%s) keep input as data; it can never become SQL.
    query = "SELECT username, role FROM app_users WHERE username = %s AND password_hash = %s"
    cur.execute(query, (username, sha256(password)))
    return cur.fetchone()


def search_vulnerable(name):
    q = f"SELECT student_id, full_name, programme FROM students WHERE full_name LIKE '%{name}%'"
    print("  SQL sent:", q)
    cur.execute(q)
    return cur.fetchall()


def search_safe(name):
    cur.execute("SELECT student_id, full_name, programme FROM students WHERE full_name LIKE %s",
                (f"%{name}%",))
    return cur.fetchall()


def demo():
    print("=== 1. Normal login (both versions) ===")
    print("vulnerable:", login_vulnerable("admin", "admin123"))
    print("safe      :", login_safe("admin", "admin123"))

    print("\n=== 2. Injection attack on login: username = admin' -- ===")
    attack = "admin' -- "
    print("vulnerable:", login_vulnerable(attack, "wrong-password"), " <-- logged in WITHOUT password!")
    print("safe      :", login_safe(attack, "wrong-password"), " <-- attack fails")

    print("\n=== 3. Injection attack on search: zzz' OR '1'='1' -- ===")
    payload = "zzz' OR '1'='1' -- "
    print("vulnerable returns", len(search_vulnerable(payload)), "rows  <-- every student leaked!")
    print("safe returns      ", len(search_safe(payload)), "rows")

    print("\n=== 4. Least privilege: app_user cannot modify data ===")
    try:
        cur.execute("DELETE FROM students")
    except mysql.connector.Error as e:
        print("Blocked by MySQL:", e)


if __name__ == "__main__":
    demo()
    cur.close()
    conn.close()
