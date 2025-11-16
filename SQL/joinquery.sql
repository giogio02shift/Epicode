#esercizio 1 e 2#
USE AdventureWorksDW;
SELECT EnglishProductName AS ProductName, EnglishProductSubcategoryName as SubcategoryName, EnglishProductCategoryName as CategoryName
FROM dimproduct D
JOIN dimproductsubcategory SUB ON D.ProductSubcategoryKey = SUB.ProductSubcategoryKey
JOIN dimproductcategory CAT ON SUB.ProductCategoryKey = CAT.ProductCategoryKey;

SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA= 'AdventureWorksDW' AND TABLE_NAME = 'diproduct' AND CONSTRAINT_NAME ='PRIMARY';

#ESERCIZIO 3(unendo factresellersales mi escono in automatico solo i prodotti venduti)#
SELECT *
FROM dimproduct D
JOIN factresellersales F ON D.ProductKey = F.ProductKey;
#VISIONE DEI PRODOTTI FINITI MA NON VENDUTI
SELECT *
FROM dimproduct D
LEFT JOIN factresellersales F ON D.ProductKey = F.ProductKey
WHERE SalesOrderNumber IS NULL
and FinishedGoodsFlag = 1;

#DISTINCT TI TOGLIE I DUPLICATI#
SELECT distinct ProductKey
FROM factresellersales;

SELECT distinct P.ProductKey, P.EnglishProductName, P.FinishedGoodsFlag
FROM dimproduct AS P
WHERE FinishedGoodsFlag = 1 and P.ProductKey NOT IN (SELECT distinct ProductKey
FROM factresellersales);
#CON UNA QUERY HO RECUPERATO TUTTI I CODICI DEI PRODOTTI VENDUTI POI CON UN ALTRA QUERY MI RECUPERO TUTTI I PRODOTTI PRESENTI NELLA TABELLA DIMPRODUCT CHE HANNO FINISHGOODFLAGS=1, QUINDI HO  RISULTATI #
#LA SUB DI QUEY HA SENSO QUANDO IO HO DELLE QUERY COMPLESSE DA DIVIDERE IN PIù QUERY ANNIDATE TRA LORO#
#ESERCIZIO 5
SELECT *
FROM dimproduct D
JOIN factresellersales FACT ON D.ProductKey = FACT.ProductKey;
#ESERCIZIO 6
SELECT SalesOrderNumber, SalesOrderLineNumber, EnglishCountryRegionName AS RegioName
FROM factresellersales FACT
JOIN dimgeography GEO ON FACT.SalesTerritoryKey = GEO.SalesTerritoryKey;
#ESERCIZIO 7
DESCRIBE dimreseller;
#esercizio 7 fatto in un altro modo
SHOW COLUMNS FROM dimreseller;
#ESERCIZIO 8
SELECT RES.ResellerKey, RES.GeographyKey, RES.ResellerName
FROM dimreseller RES
JOIN dimgeography GEO ON RES.GeographyKey = GEO.GeographyKey;
#ESERCIZIO 9
SELECT SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, OrderQuantity, TotalProductCost, EnglishProductName AS ProductName
FROM factresellersales FACT
JOIN dimproduct D ON FACT.ProductKey = D.ProductKey;

SELECT FRS.SalesOrderNumber, FRS.SalesOrderLineNumber, FRS.OrderDate, FRS.UnitPrice, FRS.OrderQuantity, FRS.TotalProductCost, DP.EnglishProductName AS ProductName, PC.EnglishProductCategoryName AS ProductCategory, DR.ResellerName, DG.StateProvinceName AS GeographicArea
FROM factresellersales FRS
JOIN dimproduct DP ON FRS.ProductKey = DP.ProductKey
JOIN dimproductsubcategory DSC ON DP.ProductSubcategoryKey = DSC.ProductSubcategoryKey
JOIN dimproductcategory PC ON DSC.ProductCategoryKey = PC.ProductCategoryKey
JOIN dimreseller DR ON FRS.ResellerKey = DR.ResellerKey
JOIN dimgeography DG ON DR.GeographyKey = DG.GeographyKey;
#esercizio 9 svolto diversamente
SELECT F.SalesOrderNumber, F.SalesOrderLineNumber, F.OrderDate, F.UnitPrice, F.OrderQuantity, F.TotalProductCost, P.ProductName, P.ProductCategory, R.ResellerName, R.GeographicArea
FROM factresellersales F

-- Subquery per prodotto + categoria
JOIN (SELECT DP.ProductKey, DP.EnglishProductName AS ProductName, PC.EnglishProductCategoryName AS ProductCategory
    FROM dimproduct DP
    JOIN dimproductsubcategory DSC ON DP.ProductSubcategoryKey = DSC.ProductSubcategoryKey
    JOIN dimproductcategory PC ON DSC.ProductCategoryKey = PC.ProductCategoryKey
) AS P ON F.ProductKey = P.ProductKey

-- Subquery per rivenditore + area geografica
JOIN (SELECT DR.ResellerKey, DR.ResellerName, DG.StateProvinceName AS GeographicArea
    FROM dimreseller DR
    JOIN dimgeography DG ON DR.GeographyKey = DG.GeographyKey) AS R ON F.ResellerKey = R.ResellerKey;





