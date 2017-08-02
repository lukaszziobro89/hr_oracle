-- variables declaration
DECLARE
  e_id   employees.employee_id%TYPE;
  f_name employees.first_name%TYPE;
  l_name employees.last_name%TYPE;
  -- cursor declaration
  CURSOR emp_cursor
  IS
    SELECT
      employee_id,
      first_name,
      last_name
    FROM employees;
  -- pl/sql block opening
BEGIN
  -- cursor opening
  OPEN emp_cursor;
  -- fetching data in loop
  LOOP
    FETCH emp_cursor INTO e_id, f_name, l_name;
    EXIT
    WHEN emp_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(e_id || ',' || f_name || ',' || l_name);
  END LOOP;
  ----cursor closure
  CLOSE emp_cursor;
  -- pl/sql block closure
END;
/