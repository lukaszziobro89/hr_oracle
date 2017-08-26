/*

Trigger prevents decreasing employees salary - throws application error when trying to decrease.

 */
CREATE OR REPLACE TRIGGER trg_emp_salary_check
  BEFORE UPDATE
  ON EMPLOYEES
  FOR EACH ROW
  BEGIN
    IF :OLD.SALARY > :NEW.SALARY THEN
      raise_application_error(-20111, 'Error! Salary can not be decreased');
    END IF;
  END;