--==============================================================================
/*
PROCEDURE TO UPDATE SALARY FOR WHOLE DEPARTMENT:

  ARGUMENTS:
    department_id_in - department id for increase
    increase_pct_in - percentage of increase (e.g. 0.5 = 50% increase)
 */
--==============================================================================
CREATE OR REPLACE PROCEDURE update_dept_salary(
  department_id_in IN employees.department_id%TYPE,
  increase_pct_in  IN NUMBER)
IS
  BEGIN
    FOR employee_rec IN
      -- for each employee where department_id is equal to id provided
    (SELECT employee_id
     FROM employees
     WHERE department_id = update_dept_salary.department_id_in
    )
    LOOP
      -- update salary
      UPDATE employees emp
      SET emp.salary = emp.salary + emp.salary * update_dept_salary.increase_pct_in
      WHERE emp.employee_id = employee_rec.employee_id;
    END LOOP;
  END update_dept_salary;