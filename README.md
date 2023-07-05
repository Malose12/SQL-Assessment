# SQL-Assessment

I used the Create Northwind Database script to create the database and insert data in the Northwind database.
I got the script from here https://github.com/microsoft/sql-server-samples/blob/master/samples/databases/northwind-pubs/instnwnd.sql since i couldn't find a backup northwind database file.

Then I went and created the requested stored procedure.

In this stored procedure, the parameters @StartDate and @EndDate define the date range for filtering orders. The @EmployeeID and @CustomerID parameters are optional and can be used to filter orders by a specific employee or customer. If these parameters are not provided, all employees or customers will be considered.

The stored procedure joins to the necessary tables "Orders, Employees, Shippers, Customers, and Order Details", in order to get the required information. The GROUP BY clause groups the results by order date, employee, customer, and shipper. The aggregated functions are used to calculate the desired metrics.

With regards to the C# solution:

I do not have adiquate knowledge to execute the solution. I still need to upskill myself in C#.
