/**

- Trigger prevents to made changes in Employees table not in working hours 9-17.
- SYSDATE return time from database location

**/

CREATE OR REPLACE TRIGGER trg_working_hours_changes
BEFORE INSERT OR UPDATE OR DELETE ON EMPLOYEES
FOR EACH ROW
  BEGIN
    IF to_char(sysdate, 'hh24') < 9 OR to_char(sysdate, 'hh24') > 17
    THEN
      raise_application_error(-20111, 'Sorry! No change can be made before 9 AM and after 5 PM');
    END IF;
  END;
