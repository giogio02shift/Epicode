SELECT *
FROM dimproduct;
SELECT *
FROM factresellersales;

#1 Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?
SELECT 
     COUNT(*) as TotaleRighe,
     COUNT(DISTINCT ProductKey) as RigheDistinte
FROM dimproduct;
#se il numero che mi esce il righe distinte corrisponde a totale righe vuoldire che productkey è chiave primaria perche la chiave primaria non può avere duplicati.

#2 Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
SELECT
     COUNT(*) AS TotaleRighe,
     COUNT(DISTINCT CONCAT(SalesOrderNumber, '-', SalesOrderLineNumber)) AS   RigheDistinte
FROM factresellersales;
#con la funzione CONCAT riusciamo a concateneare i due campi considerandoli così come uno solo per poi verificare con distinct che non ci siano duplicati e che siano univoche

#3 Conta il numero transazioni SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
SELECT 
	 COUNT(*) AS NumeroTransazioniAfter2020
FROM factresellersales
WHERE OrderQuantity >= 1 and  OrderDate>='2020-01-01';
#4 Calcola il fatturato totale FactResellerSales.SalesAmount), la quantità totale venduta FactResellerSales.OrderQuantity) e il prezzo medio di vendita FactResellerSales.UnitPrice) per prodotto DimProduct) a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!

SELECT 
	 EnglishProductName AS Productname, 
     ROUND(SUM(SalesAmount),2) AS TotalRevenue,
     SUM(OrderQuantity) AS TotalQuantity,
     ROUND(AVG(UnitPrice),2) AS AvgUnitprice
FROM factresellersales F
JOIN dimproduct P ON F.ProductKey = P.ProductKey
WHERE OrderDate>'2020-01-01'
GROUP BY productname; #La query mostra solo un prodotto perché manca il GROUP BY, che è fondamentale quando usi funzioni di aggregazione come SUM() e AVG() su una tabella con più righe. Aggiungendo GROUP BY EnglishProductName, la query restituirà un risultato per ogni prodotto.

#5 Calcola il fatturato totale FactResellerSales.SalesAmount) e la quantità totale venduta FactResellerSales.OrderQuantity) per Categoria prodotto DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!
SELECT 
     COUNT(*) as NumberRowCategory,
     COUNT(DISTINCT CONCAT(ProductCategoryKey,'-', ProductCategoryAlternateKey)) as DistinctNumberRowCategory
FROM dimproductcategory;
SELECT 
     EnglishProductCategoryName AS CategoryName,
     EnglishProductName AS ProductName,
     SUM(SalesAmount) AS TotalSalesAmount,
     SUM(OrderQuantity) AS Totalquantity
FROM dimproduct P
JOIN dimproductsubcategory SUB on P.ProductSubcategoryKey = SUB.ProductSubcategoryKey
JOIN dimproductcategory CAT on SUB.ProductCategoryKey = CAT.ProductCategoryKey
JOIN factresellersales RES on P.ProductKey = RES.ProductKey
GROUP BY CategoryName;

#Calcola il fatturato totale per area città DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.

SELECT 
     City,
     StateProvinceName, 
     OrderDate, 
     ROUND(SUM(SalesAmount),2) AS Fatturato
FROM dimgeography GEO
JOIN factresellersales RES ON GEO.SalesTerritoryKey = RES.SalesTerritoryKey
WHERE OrderDate>= '2020-01-01' 
GROUP BY OrderDate 
HAVING SUM(SalesAmount) > 60000;






     



