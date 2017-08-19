--===============================================================================================================
/*BEFORE EXECUTING THE BELOW 3 CONDITIONS MUST BE MET (run from SYS AS SYSDBA):

GRANT EXECUTE ON UTL_FILE TO HR; -- allow execute UTL_FILE package to user
CREATE DIRECTORY ORACLE_DATA AS 'F:\ORACLE_DATA'; -- create directory (ORACLE OBJECT) where file will be stored
GRANT READ,WRITE ON DIRECTORY ORACLE_DATA TO HR; -- grant reade/write privileges to user

*/
--===============================================================================================================
DECLARE
  -- variables declaration
  f_name employees.first_name%TYPE;
  l_name employees.last_name%TYPE;
  data_file utl_file.file_type;
  file_name VARCHAR2(50);

  -- cursor declaration
  CURSOR c_employees
  IS
    SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES ORDER BY last_name;
BEGIN
  select to_char(current_timestamp,'YYYY-MM-DD-HH24MISS') into file_name from dual; -- create filename with timestamp
  data_file:=utl_file.fopen('ORACLE_DATA',file_name||'.csv','w'); --create file in 'ORACLE_DATA' directory
  DBMS_OUTPUT.PUT_LINE('Employees list: ');
  DBMS_OUTPUT.PUT_LINE('----------------------');
  -- open cursor and fetch data
  OPEN c_employees;
  LOOP
    FETCH c_employees INTO f_name, l_name;
    EXIT
  WHEN c_employees%NOTFOUND; -- stop fetching when get all records
    -- print each line into console and save into CSV file
    DBMS_OUTPUT.PUT_LINE(c_employees%rowcount ||': '|| f_name || ' ' || l_name);
    utl_file.put_line(data_file, f_name || ';' || l_name);
  END LOOP;
  -- close file and cursor after saving all data
  utl_file.fclose(data_file);
  CLOSE c_employees;
END;
/