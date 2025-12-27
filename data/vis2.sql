SELECT TOP 10 * FROM Production.ProductCategory
SELECT TOP 10 * FROM Production.ProductSubcategory
SELECT TOP 10 * FROM Production.Product
SELECT TOP 10 * FROM Sales.SalesOrderDetail


SELECT
    pc.ProductCategoryID,
    pc.Name
FROM Production.ProductCategory pc
INNER JOIN Production.ProductSubcategory psc
    ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY 
    pc.ProductCategoryID,
    pc.Name


SELECT
    ppc.ProductCategoryID,
    ppc.Name,
    SUM(ssod.LineTotal) AS IntäktPerKategori
FROM Production.ProductCategory ppc
INNER JOIN Production.ProductSubcategory ppsc
    ON ppsc.ProductCategoryID = ppc.ProductCategoryID
INNER JOIN Production.Product pp
    ON pp.ProductSubcategoryID = ppsc.ProductSubcategoryID
INNER JOIN sales.SalesOrderDetail ssod
    ON ssod.ProductID = pp.ProductID
GROUP BY
    ppc.ProductCategoryID,
    ppc.Name
ORDER BY IntäktPerKategori DESC