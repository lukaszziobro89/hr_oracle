DECLARE
  save_file utl_file.file_type;
  file_name VARCHAR2(30);
TYPE var_char2 IS TABLE OF employees.last_name%TYPE;
TYPE data_2    IS TABLE OF employees.hire_date%TYPE;
TYPE v_number  IS TABLE OF employees.employee_id%TYPE;
  p_id v_number;
  f_name var_char2;
  l_name var_char2;
  mail var_char2;
  phone var_char2;
  emp_job_id var_char2;
  emp_salary v_number;
  manager v_number;
  department v_number;
  CURSOR c_employees
  IS
    SELECT EMPLOYEE_ID,
      FIRST_NAME,
      LAST_NAME,
      EMAIL,
      PHONE_NUMBER,
      JOB_ID,
      SALARY,
      MANAGER_ID,
      DEPARTMENT_ID
    FROM employees;
BEGIN
  select to_char(current_timestamp,'YYYY-MM-DD-HH24MISS') into file_name from dual; -- create filename with timestamp
  save_file:=utl_file.fopen('ORACLE_DATA',file_name||'.csv','w'); --create file in 'ORACLE_DATA' directory
  OPEN c_employees;
  utl_file.put_line(save_file, 'Employee ID' || ';' || 'First name' || ';' || 'Last name' || ';' || 'Email' || ';' || 'Phone number' || ';' || 'Job id' || ';' || 'Salary' || ';' || 'Manager ID' || ';' || 'Department ID');
  FETCH c_employees BULK COLLECT
  INTO p_id,
    f_name,
    l_name,
    mail,
    phone,
    emp_job_id,
    emp_salary,
    manager,
    department;
  CLOSE c_employees;
  FOR m IN 1..p_id.COUNT
  LOOP
    DBMS_OUTPUT.PUT_LINE(p_id(m)||';'|| f_name(m) || ';' || l_name(m) || ';' || mail(m) || ';' || phone(m) || ';' || emp_job_id(m) || ';' || emp_salary(m) || ';' || manager(m) || ';' || department(m));
    utl_file.put_line(save_file, p_id(m) || ';' || f_name(m) || ';' || l_name(m) || ';' || mail(m) || ';' || phone(m) || ';' || emp_job_id(m) || ';' || emp_salary(m) || ';' || manager(m) || ';' || department(m));
  END LOOP;
  utl_file.fclose(save_file);
END;