SELECT TOP 10 * FROM Sales.SalesOrderHeader

SELECT
    YEAR(OrderDate) AS År,
    MONTH(OrderDate) AS Månad,
    SUM(SubTotal) AS Intäkt
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) >= 2023
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY År, Månad



SELECT
    DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate),1) AS Datum,
    SUM(SubTotal) AS Intäkt
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) >= 2023
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Datum


SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate > '2025-05-31'
ORDER BY OrderDate DESC