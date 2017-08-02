DECLARE
  -- declaring variables with type inheritance from relevant columns
  e_id         employees.employee_id%TYPE;
  f_name       employees.first_name%TYPE;
  l_name       employees.last_name%TYPE;
  earnings     employees.salary%TYPE;
  emp_dept     departments.department_name%TYPE;
  emp_position jobs.job_title%TYPE;

  --declaring cursor
  CURSOR emp_cursor
  IS
    -- retrieve each employee which salary is above average salary for all employees
    SELECT
      employee_id,
      first_name,
      last_name,
      salary,
      job_title,
      department_name
    FROM employees
      INNER JOIN departments
        ON (employees.department_id = departments.department_id)
      INNER JOIN jobs
        ON (employees.job_id = jobs.job_id)
    WHERE salary >
          (SELECT AVG(salary)
           FROM employees
          );
  -- beginning PL/SQL block
BEGIN
  -- open cursor
  OPEN emp_cursor;
  LOOP
    -- fetch all data into cursor
    FETCH emp_cursor INTO e_id, f_name, l_name, earnings, emp_position, emp_dept;
    EXIT
    WHEN emp_cursor%NOTFOUND;
    -- print results in console
    dbms_output.put_line(
        e_id || ',' || f_name || ',' || l_name || ',' || earnings || ',' || emp_position || ',' || emp_dept);
  END LOOP;
  CLOSE emp_cursor;
END;
