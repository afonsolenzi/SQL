
--Sql queries based on this bellow mentioned article, but running queries for a diferent dataset(Northwind).
--Also the queries here in this git are focused on sql server instead of mysql as proposed in the article, just to understand diferences, in this case we have in the
--sql server to adapt the NTH function from Mysql using concatenated queries and where clause as a workaround.

--In the Northwind dataset i added a collumn for the salary and another one for job_description.
--But if you just go straight to the pratice, you can just follow allong with the dataset used in the article.

--Article: https://www.analyticsvidhya.com/blog/2020/12/window-function-a-must-know-sql-concept/
--Dataset Northwind: https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/linq/downloading-sample-databases


TESTS SCRIPTS

--Suppose you want to determine the total salary of all the employees in the company
use Northwind
select sum(salary) as total_salary from Employees

--How about determining the total salary of employees per job category? 
select job_description , sum(salary) as total_salary  from Employees group by job_description

--to display the total salary of employees along with every row value
--window_function_name(<expression>) OVER ( )
select *, sum(salary)  OVER() as total_salary from employees 

--to display the total salary per job category for all the rows
--window_function_name(<expression>) OVER (<partition_by_clause>)
select *, sum(salary)  OVER(PARTITION BY job_description)  as total_job_salary  from employees

--to display the total salary per job category, ordered by olders employess per HireDate for all the rows
--window_function_name(<expression>) OVER (<partition_by_clause> <order_clause>)
select *, sum(salary)  OVER(PARTITION BY job_description order by HireDate asc)  as total_job_salary  from employees

--Sometimes your dataset might not have a column depicting the sequential order of the rows, 
--as is the case with our dataset. In that case, we can make use of the ROW_NUMBER() window function. 
--It assigns a unique sequential number to each row of the table.
select *, ROW_NUMBER() over (PARTITION BY job_description ORDER BY EmployeeID) as "row_number" from employees

--The RANK() window function, as the name suggests, ranks the rows within their partition based on the given condition
select *, 
ROW_NUMBER() over (PARTITION BY job_description ORDER BY salary) as "row_number" ,
RANK() over (PARTITION BY job_description ORDER BY salary) as "rank_row"
from employees

--The DENSE_RANK() function is similar to the RANK() except for one difference, it doesn’t skip any ranks when ranking rows.
select *, 
ROW_NUMBER() over (PARTITION BY job_description ORDER BY salary) as "row_number" ,
RANK() over (PARTITION BY job_description ORDER BY salary) as "rank_row",
DENSE_RANK() over (PARTITION BY job_description ORDER BY salary) as "dense_rank"
from employees

--Print nth value within each partition using nth_value function*/
select * from (select *, 
	ROW_NUMBER() over (PARTITION BY job_description ORDER BY salary) as "row_number" ,
	RANK() over (PARTITION BY job_description ORDER BY salary) as "rank_row",
	DENSE_RANK() over (PARTITION BY job_description ORDER BY salary) as "dense_rank"
	from employees) as tab where tab.rank_row = 3

--let’s find the quartile for each row based on the SALARY of the employee
select *, 
NTILE(4) over(order by salary) as "quartile"
from Employees


--Often, you might want to compare the value of the current row to that of the preceding or succeeding row. 
--It helps in the easy analysis of the data. The LEAD() and LAG() window functions are there just for this purpose.
select *,
LEAD(salary, 1) Over(partition by job_description order by salary) as sal_next,
LAG(salary, 1) Over(partition by job_description order by salary) as sal_previous
from Employees

