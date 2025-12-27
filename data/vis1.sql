USE AdvetureWorks2025



SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory
SELECT TOP 100 * FROM Production.Product


SELECT 
    pc.Name AS CategoryName
FROM Production.ProductCategory pc



SELECT 
    pc.Name AS CategoryName,
    COUNT(*) AS SubcategoryName
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory psc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
ORDER BY SubcategoryName DESC



SELECT 
    pc.Name AS CategoryName,
    COUNT(DISTINCT p.ProductID) AS ProductCount
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory psc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = psc.ProductSubcategoryID
GROUP BY pc.Name
ORDER BY ProductCount DESC




SELECT 
    pc.Name AS CategoryName,
    psc.Name AS SubcategoryName,
    COUNT(DISTINCT p.ProductID) AS ProductCount
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory psc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = psc.ProductSubcategoryID
WHERE pc.Name = 'Bikes'
GROUP BY pc.Name, psc.Name
ORDER BY ProductCount DESC