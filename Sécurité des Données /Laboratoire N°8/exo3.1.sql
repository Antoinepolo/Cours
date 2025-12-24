GO
USE AdventureWorks2022;
GO

SELECT Product.Name, Product.ProductNumber, ProductModel.Name AS Product_Model_Name
FROM Production.Product INNER JOIN Production.ProductModel
ON ProductModel.ProductModelID = ProductModel.ProductModelID
WHERE Product.ProductID = 777;