SELECT TOP 10 * FROM Sales.SalesOrderHeader

SELECT
    YEAR(OrderDate) AS År,
    SUM(SubTotal) AS Intäkt,
    COUNT(*) As AntalOrdrar
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY År
