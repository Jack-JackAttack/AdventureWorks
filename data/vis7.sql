SELECT TOP 10 * FROM Sales.SalesTerritory
SELECT TOP 10 * FROM Sales.SalesOrderHeader
SELECT TOP 10 * FROM Sales.Customer
SELECT TOP 10 * FROM Sales.Store



SELECT
    CASE
        WHEN sc.StoreID IS NULL THEN 'Individual'
        ELSE 'Store'
    END AS Kundtyp,
    COUNT(*) AS AntalOrdrar
FROM Sales.SalesOrderHeader ssoh
JOIN Sales.Customer sc ON sc.CustomerID = ssoh.CustomerID
GROUP BY
    CASE
        WHEN sc.StoreID IS NULL THEN 'Individual'
        ELSE 'Store'
    END



SELECT
    sst.[Group] AS 'Region',
    CASE
        WHEN sc.StoreID IS NULL THEN 'Individual'
        ELSE 'Store'
    END AS Kundtyp,
    COUNT(*) AS AntalOrdrar,
    SUM(ssoh.SubTotal) AS 'Försäljning',
    AVG(ssoh.SubTotal) AS 'GenomsnittligtOrdervärde'
FROM Sales.SalesOrderHeader ssoh
JOIN Sales.Customer sc ON sc.CustomerID = ssoh.CustomerID
JOIN Sales.SalesTerritory sst ON ssoh.TerritoryID = sst.TerritoryID
GROUP BY
    CASE
        WHEN sc.StoreID IS NULL THEN 'Individual'
        ELSE 'Store'
    END,
    sst.[Group]
ORDER BY
    Region,
    GenomsnittligtOrdervärde DESC
    


SELECT
    Region,
    Kundtyp,
    AntalOrdrar,
    Försäljning,
    GenomsnittligtOrdervärde,
    -- "Beräkna: Total försäljning / Antal ordrar per region"
    SUM(Försäljning) OVER(PARTITION BY Region) / SUM(AntalOrdrar) OVER(PARTITION BY Region) AS 'GenomsnittRegion'
FROM(
    SELECT
        sst.[Group] AS 'Region',
        CASE
            WHEN sc.StoreID IS NULL THEN 'Individual'
            ELSE 'Store'
        END AS Kundtyp,
        COUNT(*) AS AntalOrdrar,
        SUM(ssoh.SubTotal) AS 'Försäljning',
        AVG(ssoh.SubTotal) AS 'GenomsnittligtOrdervärde'
    FROM Sales.SalesOrderHeader ssoh
    JOIN Sales.Customer sc ON sc.CustomerID = ssoh.CustomerID
    JOIN Sales.SalesTerritory sst ON ssoh.TerritoryID = sst.TerritoryID
    GROUP BY
        CASE
            WHEN sc.StoreID IS NULL THEN 'Individual'
            ELSE 'Store'
        END,
        sst.[Group]
) AS Subquery
ORDER BY
    GenomsnittRegion DESC,
    GenomsnittligtOrdervärde DESC



SELECT
    sst.[Group] AS Region,
    SUM(CASE WHEN sc.StoreID IS NULL THEN ssoh.SubTotal ELSE 0 END) / COUNT(CASE WHEN sc.StoreID IS NULL THEN 1 END) AS 'GenomsnittIndividual',
    SUM(CASE WHEN sc.StoreID IS NOT NULL THEN ssoh.SubTotal ELSE 0 END) / COUNT(CASE WHEN sc.StoreID IS NOT NULL THEN 1 END) AS 'GenomsnittStore',
    SUM(ssoh.SubTotal) / COUNT(*) AS 'GenomsnittRegion'
FROM Sales.SalesOrderHeader ssoh
JOIN Sales.Customer sc ON sc.CustomerID = ssoh.CustomerID
JOIN Sales.SalesTerritory sst ON sst.TerritoryID = ssoh.TerritoryID
GROUP BY
    sst.[Group]
ORDER BY
    GenomsnittRegion DESC





