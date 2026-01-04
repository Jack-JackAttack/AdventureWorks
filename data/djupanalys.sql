SELECT TOP 10 * FROM Sales.SalesOrderHeader
SELECT TOP 10 * FROM Sales.SalesOrderDetail
SELECT TOP 10 * FROM Production.Product
SELECT TOP 10 * FROM Production.ProductSubcategory
SELECT TOP 10 * FROM Production.ProductCategory



-- ALTERNATIV B: Produktportfölj-analys
-- Analysfrågor:
-- •	Vilka produkter är "winners" (hög försäljning, hög marginal)?
-- •	Vilka är "losers" (låg försäljning eller negativ marginal)?
-- •	Vilka produkter bör vi sluta sälja? Vilka bör vi satsa mer på?
-- •	Finns produkter med hög kvantitet men låg intäkt?
-- Du behöver:
-- •	3-4 nya SQL-queries för att analysera produkters lönsamhet och prestanda
-- •	Minst 1 pivot tables för att jämföra produkter
-- •	3 nya visualiseringar (t.ex. scatter plot marginal×försäljning, grupperade staplar för kategorier, matris för winners/losers)




--Winners
SELECT
    TOP 5
    ssod.ProductID,
    pp.Name,
    SUM(ssod.OrderQty) AS 'AntalSåldaEnheter',
    SUM(ssod.LineTotal) AS 'TotalFörsäljning',
    SUM((pp.ListPrice - pp.StandardCost) * ssod.OrderQty) AS 'Marginal'
FROM Sales.SalesOrderHeader ssoh
JOIN Sales.SalesOrderDetail ssod ON ssoh.SalesOrderID = ssod.SalesOrderID
JOIN Production.Product pp ON ssod.ProductID = pp.ProductID
GROUP BY
    ssod.ProductID,
    pp.Name
ORDER BY 
    TotalFörsäljning DESC,
    Marginal DESC



--Loosers
SELECT
    TOP 5
    ssod.ProductID,
    pp.Name,
    SUM(ssod.OrderQty) AS 'AntalSåldaEnheter',
    SUM(ssod.LineTotal) AS 'Totalförsäljning',
    SUM((pp.ListPrice - pp.StandardCost) * ssod.OrderQty) AS 'Marginal'
FROM Sales.SalesOrderHeader ssoh
JOIN Sales.SalesOrderDetail ssod ON ssoh.SalesOrderID = ssod.SalesOrderID
JOIN Production.Product pp ON ssod.ProductID = pp.ProductID
GROUP BY
    ssod.ProductID,
    pp.Name
ORDER BY 
    Totalförsäljning,
    Marginal



--Många ordrar, lägre försäljning
SELECT
    TOP 5
    ssod.ProductID,
    pp.Name,
    SUM(ssod.OrderQty) AS 'AntalSåldaEnheter',
    SUM(ssod.LineTotal) AS 'Totalförsäljning',
    SUM((pp.ListPrice - pp.StandardCost) * ssod.OrderQty) AS 'Marginal'
FROM Sales.SalesOrderHeader ssoh
JOIN Sales.SalesOrderDetail ssod ON ssoh.SalesOrderID = ssod.SalesOrderID
JOIN Production.Product pp ON ssod.ProductID = pp.ProductID
GROUP BY
    ssod.ProductID,
    pp.Name
ORDER BY 
    AntalSåldaEnheter DESC,
    Totalförsäljning



--Pivot table
SELECT
    pp.ProductID,
    pp.Name,
    pc.Name AS 'Category',
    SUM(ssod.OrderQty) AS 'AntalSåldaEnheter',
    SUM(ssod.LineTotal) AS 'TotalFörsäljning',
    SUM((pp.ListPrice - pp.StandardCost) * ssod.OrderQty) AS TotalMarginal
FROM Sales.SalesOrderDetail ssod
JOIN Production.Product pp ON ssod.ProductID = pp.ProductID
JOIN Production.ProductSubcategory ppsc ON pp.ProductSubcategoryID = ppsc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ppsc.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    pp.ProductID,
    pp.Name,
    pc.Name
