SELECT TOP 100 * FROM Sales.SalesTerritory
SELECT TOP 100 * FROM Sales.SalesOrderHeader
SELECT TOP 10 * FROM Sales.Customer


SELECT
    sst.TerritoryID,
    sst.[Group] AS Region,
    COUNT(DISTINCT sc.CustomerID) AS AntalKunder,
    SUM(ssoh.SubTotal) AS TotalFörsäljning
FROM Sales.SalesTerritory sst
JOIN Sales.SalesOrderHeader ssoh ON sst.TerritoryID = ssoh.TerritoryID
JOIN Sales.Customer sc ON ssoh.CustomerID = sc.CustomerID
GROUP BY
    sst.TerritoryID,
    sst.[Group]



SELECT
    sst.[Group] AS Region,
    COUNT(DISTINCT sc.CustomerID) AS AntalKunder,
    SUM(ssoh.SubTotal) AS Försäljning
FROM Sales.SalesTerritory sst
JOIN Sales.SalesOrderHeader ssoh ON sst.TerritoryID = ssoh.TerritoryID
JOIN Sales.Customer sc ON ssoh.CustomerID = sc.CustomerID
GROUP BY
    sst.[Group]
ORDER BY Försäljning DESC