--===============================================================================================================
/*BEFORE EXECUTING THE BELOW 3 CONDITIONS MUST BE MET (run from SYS AS SYSDBA):

GRANT EXECUTE ON UTL_FILE TO HR; -- allow execute UTL_FILE package to user
CREATE DIRECTORY ORACLE_DATA AS 'F:\ORACLE_DATA'; -- create directory (ORACLE OBJECT) where file will be stored
GRANT READ,WRITE ON DIRECTORY ORACLE_DATA TO HR; -- grant reade/write privileges to user

*/
--===============================================================================================================
DECLARE
  --variables declaration
  file_name VARCHAR2(50);
  save_file utl_file.file_type;

  -- cursor declaration
  CURSOR c_employees
  IS
    SELECT * FROM employees ORDER BY last_name;
  c_emp c_employees%ROWTYPE;
BEGIN
  select to_char(current_timestamp,'YYYY-MM-DD-HH24MISS') into file_name from dual; -- create filename with timestamp
  save_file:=utl_file.fopen('ORACLE_DATA',file_name||'.csv','w'); --create file in 'ORACLE_DATA' directory
  -- open cursor and fetch data
  OPEN c_employees;
  utl_file.put_line(save_file,'Lp' ||';'|| 'Employee ID' ||';'|| 'First name' ||';'|| 'Last name' ||';'|| 'Email' ||';'|| 'Phone number'||';'|| 'Hire date' ||';'|| 'Job id' ||';'|| 'Salary' ||';'|| 'Manager ID' ||';'|| 'Department ID');
  LOOP
    FETCH c_employees INTO c_emp;
    EXIT
  WHEN c_employees%NOTFOUND; -- stop fetching when get all records
    -- print each line into console and save into CSV file
    DBMS_OUTPUT.PUT_LINE(c_employees%ROWCOUNT ||';'|| c_emp.employee_id ||';'|| c_emp.first_name ||';'||c_emp.last_name ||';'|| c_emp.email ||';'|| c_emp.phone_number||';'|| c_emp.hire_date||';'|| c_emp.job_id||';'|| c_emp.salary||';'|| c_emp.manager_id||';'|| c_emp.department_id);
    utl_file.put_line(save_file,c_employees%ROWCOUNT ||';'|| c_emp.employee_id ||';'|| c_emp.first_name ||';'||c_emp.last_name ||';'|| c_emp.email ||';'|| c_emp.phone_number||';'|| c_emp.hire_date||';'|| c_emp.job_id||';'|| c_emp.salary||';'|| c_emp.manager_id||';'|| c_emp.department_id);
  END LOOP;
  -- close file and cursor after saving all data
  utl_file.fclose(save_file);
  CLOSE c_employees;
END;
/