--==============================================================================
SELECT
  first_name,
  last_name,
  job_title
FROM employees
  INNER JOIN jobs USING (job_id)
ORDER BY 1;
--==============================================================================
SELECT
  department_id,
  department_name,
  ROUND(AVG(salary)) AS srednia_placa
FROM EMPLOYEES
  INNER JOIN departments USING (department_id)
GROUP BY department_id,
  department_name
ORDER BY srednia_placa DESC;
--==============================================================================
SELECT
  first_name,
  last_name,
  TO_CHAR(hire_date, 'YYYY') AS rok_zatrudnienia
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2005';
--==============================================================================
SELECT
  COUNTRY_NAME,
  CITY,
  DEPARTMENT_NAME
FROM COUNTRIES
  INNER JOIN locations USING (country_id)
  INNER JOIN departments USING (location_id)
ORDER BY Department_name;
--==============================================================================
SELECT
  FIRST_NAME,
  LAST_NAME,
  SALARY
FROM employees
WHERE salary =
      (SELECT MAX(salary)
       FROM employees
      );
--==============================================================================
SELECT
  DEPARTMENT_ID,
  department_name,
  ROUND(AVG(SALARY)) srednia_pensja
FROM EMPLOYEES
  INNER JOIN departments USING (department_id)
GROUP BY department_id,
  department_name
ORDER BY department_id;
--==============================================================================
SELECT
  LOCATION_ID,
  CITY,
  ROUND(AVG(salary)) AS srednia_pensja
FROM LOCATIONS
  INNER JOIN departments USING (location_id)
  INNER JOIN employees USING (department_id)
GROUP BY LOCATION_ID,
  CITY
ORDER BY srednia_pensja DESC;
--==============================================================================
SELECT
  Country_name,
  ROUND(AVG(salary)) AS srednia_pensja
FROM COUNTRIES
  INNER JOIN LOCATIONS USING (country_id)
  INNER JOIN departments USING (location_id)
  INNER JOIN employees USING (department_id)
GROUP BY country_name
ORDER BY srednia_pensja DESC;
--==============================================================================
SELECT
  d.DEPARTMENT_ID,
  DEPARTMENT_NAME,
  d.MANAGER_ID,
  First_name,
  last_name
FROM DEPARTMENTS d
  INNER JOIN employees e ON d.manager_id = e.manager_id
WHERE d.manager_id IN (SELECT manager_id
                       FROM departments)
ORDER BY d.department_id;
--==============================================================================
