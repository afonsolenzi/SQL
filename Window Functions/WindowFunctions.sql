
use Northwind

--alter table employees add job_description nvarchar(50)

UPDATE employees
SET job_description = 'data scientist'
WHERE EmployeeID = 1

UPDATE employees
SET job_description = 'data scientist'
WHERE EmployeeID = 2

UPDATE employees
SET job_description = 'data engineer'
WHERE EmployeeID = 3

UPDATE employees
SET salary = 10002
WHERE EmployeeID = 4

UPDATE employees
SET job_description = 'data engineer'
WHERE EmployeeID = 5

UPDATE employees
SET job_description = 'data engineer'
WHERE EmployeeID = 6

UPDATE employees
SET job_description = 'data analyst'
WHERE EmployeeID = 7

UPDATE employees
SET job_description = 'data analyst'
WHERE EmployeeID = 8

UPDATE employees
SET job_description = 'data analyst'
WHERE EmployeeID = 9