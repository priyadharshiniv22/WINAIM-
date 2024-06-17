#Question::::Create tables for employees, departments, and salaries. "employees" table should include: employee_id, first_name, last_name,
#department_id, hire_date. "departments" table should include: department_id, department_name.
#"salaries" table should include: employee_id, salary, from_date to_date.
#Answer :

create table employee(employee_id int, first_name varchar(50),last_name varchar(30),department_id int,hire_date date);
create table department(department_id int,department_name varchar(50));
create table salaries(employee_id int,salary int, from_date date,to_date date);


# 1) Write a query to find all employees who have been hired in the last year.
#Answer :
SELECT *
FROM employee
WHERE hire_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR);


# 2) Write a query to calculate the total salary expenditure for each department.
#Answer :
SELECT
    d.department_id,
    d.department_name,
    SUM(s.salary) AS total_salary_expenditure
FROM
    department d
JOIN
    employee e ON d.department_id = e.department_id
JOIN
    salaries s ON e.employee_id = s.employee_id
GROUP BY
    d.department_id, d.department_name
ORDER BY
    d.department_id;
    
#3) Write a query to find the top 5 highest-paid employees along with their department names.
#Answer :
SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    s.salary
FROM
    (SELECT
        employee_id,
        MAX(salary) AS max_salary
     FROM
        salaries
     GROUP BY
        employee_id
     ORDER BY
        max_salary DESC
     LIMIT 5) top_salaries
JOIN
    salaries s ON top_salaries.employee_id = s.employee_id AND top_salaries.max_salary = s.salary
JOIN
    employee e ON s.employee_id = e.employee_id
JOIN
    department d ON e.department_id = d.department_id
ORDER BY
    s.salary DESC;