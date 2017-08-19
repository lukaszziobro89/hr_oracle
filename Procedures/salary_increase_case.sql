--===================================================================
/*
Procedure which updates employees salary using SELECT CASE:
 - when salary between 4000-5000 then plus 100
 - when salary between 3000-4000 then plus 300
 - when salary between 2000-3000 then plus 500
*/
--===================================================================
DECLARE
  -- VARIABLES DECLARATION ------------------------------------------
  v_salary employees.salary%TYPE;
  v_emp_id  employees.employee_id%TYPE;

  -- CURSOR DECLARATION ---------------------------------------------
  CURSOR c_emplyoees
  IS
    SELECT
      employee_id,
      salary
    FROM employees
    WHERE salary BETWEEN 2000 AND 5000;

-- PL/SQL BLOCK -----------------------------------------------------
BEGIN
  -- OPEN CURSOR
  OPEN c_emplyoees;
  -- FETCH DATA -----------------------------------------------------
  LOOP
    FETCH c_emplyoees INTO v_emp_id, v_salary;
    CASE
      -- CASE WHEN SALARY BETWEEN 4000 and 5000 ---------------------
      WHEN v_salary BETWEEN 4000 AND 5000 THEN
        UPDATE EMPLOYEES
        SET salary = salary + 100 -- increase with 100
        WHERE employee_id = v_emp_id;
      -- CASE WHEN SALARY BETWEEN 3000 and 4000 ---------------------
      WHEN v_salary BETWEEN 3000 AND 4000 THEN
        UPDATE EMPLOYEES
        SET salary = salary + 300 -- increase with 300
        WHERE employee_id = v_emp_id;
      -- CASE WHEN SALARY BETWEEN 2000 and 3000 ---------------------
      WHEN v_salary BETWEEN 2000 AND 3000 THEN
        UPDATE EMPLOYEES
        SET salary = salary + 500 -- increase with 500
        WHERE employee_id = v_emp_id;
    END CASE;
    -- STOP INCREASING WHEN ALL RELEVANT RECORDS UPDATED ------------
    EXIT WHEN c_emplyoees%NOTFOUND;
  END LOOP; 
  -- CLOSE CURSOR ---------------------------------------------------
  CLOSE c_emplyoees;
  -- CLOSE PL/SQL BLOCK ---------------------------------------------
END;
/
