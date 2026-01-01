SELECT TOP 100 * FROM Sales.SalesOrderDetail
SELECT TOP 100 * FROM Production.Product



SELECT
    ssod.ProductID,
    SUM(ssod.LineTotal) AS "IntäktPerProdukt",
    pp.Name
FROM Sales.SalesOrderDetail ssod
JOIN Production.Product pp on ssod.ProductID = pp.ProductID
GROUP BY
    ssod.ProductID,
    pp.Name
ORDER BY IntäktPerProdukt DESC



SELECT TOP 10 *
FROM (
    SELECT
        ssod.ProductID,
        SUM(ssod.LineTotal) AS "IntäktPerProdukt",
        pp.Name
    FROM Sales.SalesOrderDetail ssod
    JOIN Production.Product pp on ssod.ProductID = pp.ProductID
    GROUP BY
        ssod.ProductID,
        pp.Name
) AS test
ORDER BY IntäktPerProdukt DESC



SELECT TOP 10
    ssod.ProductID,
    SUM(ssod.LineTotal) AS "IntäktPerProdukt",
    pp.Name
FROM Sales.SalesOrderDetail ssod
JOIN Production.Product pp on ssod.ProductID = pp.ProductID
GROUP BY
    ssod.ProductID,
    pp.Name
ORDER BY IntäktPerProdukt DESC