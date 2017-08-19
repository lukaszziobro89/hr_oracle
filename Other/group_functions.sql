--==============================================================================
/*1. Select highest salary for each department */
SELECT
  NVL(to_char(department_id), 'NO DEPARTMENT ASSIGNED'),
  MAX(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;
--==============================================================================
/*2. Select highest salary for each department */
SELECT
  NVL(to_char(department_id), 'NO DEPARTMENT ASSIGNED'),
  MAX(salary) AS HIGHEST_SALARY
FROM employees
GROUP BY department_id
ORDER BY HIGHEST_SALARY DESC;
--==============================================================================
/*3. Select distinct average salary for each department */
SELECT
  NVL(to_char(department_id), 'NO DEPARTMENT ASSIGNED'),
  ROUND(AVG(DISTINCT salary)) AS AVERAGE_SALARY
FROM employees
GROUP BY department_id
ORDER BY 2;
--==============================================================================
/*4. Select highest salary for departments 50, 60, 80 */
SELECT
  NVL(to_char(department_id), 'NO DEPARTMENT ASSIGNED'),
  MAX(salary)
FROM employees
WHERE department_id IN (50, 60, 80)
GROUP BY department_id
ORDER BY 2 DESC;
--==============================================================================
/*6. Select lowest salary for each department where last name does not contain 'e' letter */
SELECT
  department_id,
  last_name,
  MIN(salary)
FROM employees
WHERE last_name NOT LIKE '%e%'
GROUP BY department_id,
  last_name
ORDER BY 1;
--==============================================================================
