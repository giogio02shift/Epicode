SELECT * from dimproduct;
SELECT  ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag FROM dimproduct;
SELECT  ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag as fgf FROM dimproduct;
SELECT  ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag as fgf 
FROM dimproduct
WHERE FinishedGoodsFlag=1;
SELECT  ProductKey, ProductAlternateKey, EnglishProductName, StandardCost, listprice, Listprice - StandardCost as Markup
FROM dimproduct
WHERE ProductAlternateKey like "fr%" or ProductAlternateKey LIKE "fr%";
SELECT  ProductKey, ProductAlternateKey, EnglishProductName, StandardCost, listprice, Listprice - StandardCost as Markup, FinishedGoodsFlag
FROM dimproduct
WHERE (ListPrice>1000 and ListPrice<2000) and (ProductAlternateKey like "fr%" or ProductAlternateKey LIKE "fr%") and (FinishedGoodsFlag= 1);
select * FROM dimemployee;
select * FROM dimemployee
WHERE SalesPersonFlag= 1;

select * from factresellersales;

select * from factresellersales where (OrderDate > "2020-01-01") and (ProductKey in(597, 598, 477, 214));
select SalesOrderNumber, OrderDate, ProductKey, OrderQuantity, UnitPrice, TotalProductCost, SalesAmount, SalesAmount - TotalProductCost as Markup from factresellersales where (OrderDate > '2020-01-01') AND (ProductKey in (597, 598, 477, 214));


