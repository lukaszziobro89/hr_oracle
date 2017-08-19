--===============================================================================================================
/*BEFORE EXECUTING THE BELOW 3 CONDITIONS MUST BE MET (run from SYS AS SYSDBA):

GRANT EXECUTE ON UTL_FILE TO HR; -- allow execute UTL_FILE package to user
CREATE DIRECTORY ORACLE_DATA AS 'F:\ORACLE_DATA'; -- create directory (ORACLE OBJECT) where file will be stored
GRANT READ,WRITE ON DIRECTORY ORACLE_DATA TO HR; -- grant reade/write privileges to user


-- PROCEDURE TO INCREASE SALARY FOR WHOLE DEPARTMENT WITH SAVING 2 CSV FILES:
      1) first file holds data before increase
      2) second file holds data after increase

    ARGUMENTS:
    department_id_in - department id for increase
    increase_pct_in - percentage of increase (e.g. 0.5 = 50% increase)
*/
--===============================================================================================================
CREATE OR REPLACE PROCEDURE increase_csv(
  dept_id IN employees.department_id%TYPE,
  inc_pct IN NUMBER)
IS
  -- VARIABLES DECLARATION -----------------------------------------------------
  v_emp_id    employees.employee_id%TYPE;
  v_fname     employees.first_name%TYPE;
  v_lname     employees.last_name%TYPE;
  v_salary    employees.salary%TYPE;
  file_before utl_file.FILE_TYPE;
  file_after  utl_file.FILE_TYPE;
  file_name   VARCHAR2(50);

  -- CURSOR DECLARATION - DATA BEFORE INCREASE ---------------------------------
  CURSOR c_employees_before
  IS
    SELECT
      EMPLOYEE_ID,
      FIRST_NAME,
      LAST_NAME,
      SALARY
    FROM EMPLOYEES
    WHERE department_id = dept_id
    ORDER BY EMPLOYEE_ID ASC;
  -- CURSOR DECLARATION - DATA AFTER INCREASE ----------------------------------
  CURSOR c_employees_after
  IS
    SELECT
      EMPLOYEE_ID,
      FIRST_NAME,
      LAST_NAME,
      SALARY
    FROM EMPLOYEES
    WHERE department_id = dept_id
    ORDER BY EMPLOYEE_ID ASC;

  --PL/SQL BLOCK ---------------------------------------------------------------
  BEGIN
    SELECT to_char(current_timestamp, 'YYYY-MM-DD-HH24MISS') INTO file_name FROM dual; -- create filename with timestamp
    file_before := utl_file.fopen('ORACLE_DATA', file_name || '_before.csv', 'w'); -- create and open file 'before_update'
    file_after := utl_file.fopen('ORACLE_DATA', file_name || '_after.csv', 'w'); -- create and open file 'after_update'

    -- OPEN CURSOR AND FETCH DATA BEFORE UPDATE --------------------------------
    OPEN c_employees_before;
    LOOP
      FETCH c_employees_before
      INTO v_emp_id, v_fname, v_lname, v_salary;
      EXIT
      WHEN c_employees_before%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
          c_employees_before%ROWCOUNT || ': ' || v_emp_id || ': ' || v_fname || ' ' || v_lname || ' ' || v_salary); -- print into console
      utl_file.put_line(file_before, v_emp_id || ': ' || v_fname || ';' || v_lname || ';' || v_salary); -- print into file
    END LOOP;
    utl_file.fclose(file_before); -- close file with data 'before update'
    CLOSE c_employees_before; -- close cursor before update

    -- INCREASE SALARY----------------------------------------------------------
    FOR employee_rec IN -- for each record that meets condition update in LOOP
    (SELECT employee_id
     FROM employees
     WHERE department_id = increase_csv.dept_id -- condition to retrieve only department records
    )
    LOOP
      UPDATE employees emp -- update previously fetched records with new salary
      SET emp.salary = emp.salary + emp.salary * increase_csv.inc_pct
      WHERE emp.employee_id = employee_rec.employee_id;
    END LOOP;

    -- OPEN CURSOR AND FETCH DATA AFTER UPDATE ---------------------------------
    OPEN c_employees_after;
    LOOP
      FETCH c_employees_after
      INTO v_emp_id, v_fname, v_lname, v_salary;
      EXIT
      WHEN c_employees_after%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(c_employees_after%ROWCOUNT || ': ' || v_emp_id || ': ' || v_fname || ' ' || v_lname || ' ' || v_salary);
      utl_file.put_line(file_after, v_emp_id || ': ' || v_fname || ';' || v_lname || ';' || v_salary);
    END LOOP;
    utl_file.fclose(file_after); -- close file with data 'after update'
    CLOSE c_employees_after; -- close cursor after update
    -- close PLSQL block -------------------------------------------------------
  END increase_csv;
/