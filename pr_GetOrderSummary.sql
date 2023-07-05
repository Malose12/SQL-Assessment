CREATE PROCEDURE pr_GetOrderSummary
    @StartDate DATE,
    @EndDate DATE,
    @EmployeeID INT = NULL,
    @CustomerID VARCHAR(10) = NULL
AS
BEGIN
--Testing Variables 
--DECLARE @StartDate DATE = '1996-01-01',
--		@EndDate DATE = '1996-08-31',
--		@EmployeeID INT = NULL,
--		@CustomerID VARCHAR(10) = NULL


    SELECT 
        CONCAT(e.TitleOfCourtesy, ' ', e.FirstName, ' ', e.LastName) AS EmployeeFullName,
        s.CompanyName AS ShipperCompanyName,
        c.CompanyName AS CustomerCompanyName,
        COUNT(*) AS NumberOfOrders,
        CAST(o.OrderDate AS DATE) AS [Date],
        SUM(o.Freight) AS TotalFreightCost,
        COUNT(DISTINCT od.ProductID) AS NumberOfDifferentProducts,
        SUM(od.UnitPrice * od.Quantity) AS TotalOrderValue
    FROM
        Orders o
        INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
        INNER JOIN Shippers s ON o.ShipVia = s.ShipperID
        INNER JOIN Customers c ON o.CustomerID = c.CustomerID
        INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
    WHERE
        (@EmployeeID IS NULL OR o.EmployeeID = @EmployeeID)
        AND (@CustomerID IS NULL OR o.CustomerID = @CustomerID)
        AND o.OrderDate >= @StartDate
        AND o.OrderDate <= @EndDate
    GROUP BY
        CAST(o.OrderDate AS DATE),
        e.EmployeeID,
        CONCAT(e.TitleOfCourtesy, ' ', e.FirstName, ' ', e.LastName),
        s.ShipperID,
        s.CompanyName,
        c.CustomerID,
        c.CompanyName
    ORDER BY
        [Date], EmployeeFullName, ShipperCompanyName, CustomerCompanyName
END
