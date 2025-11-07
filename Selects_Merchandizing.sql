-- 1) Selects the different products with type 'Short' and orders them by their size count
-- Returns the size and the count of products for each size, sorted by the count in descending order
SELECT p.Dimensions AS Talla, COUNT(*) AS NombreDeProductes
FROM Product p
         JOIN TypeProduct tp ON p.TypeName = tp.TypeName
WHERE tp.TypeName LIKE '%Short%'
GROUP BY p.Dimensions
ORDER BY NombreDeProductes DESC;

-- 2) Returns the name and cost of products with certain criteria:
-- XL size and cost > 350, or related to 'Casual Wear' activity with cost > 110, or with 'UV Protection' feature and cost > 55
-- Orders the result by product name
SELECT p.NameProduct, p.Cost
FROM Product p
         LEFT JOIN Accessory a ON p.NameProduct = a.NameAccessory
         JOIN Activity act ON p.IdActivity = act.IdActivity
WHERE (p.Dimensions = 'XL' AND p.Cost > 350)
   OR (act.NameActivity = 'Casual Wear' AND p.Cost > 110)
   OR (a.Features = 'UV Protection' AND p.Cost > 55)
ORDER BY p.NameProduct;

-- 3) Returns the identifier, name, description, and count of products for the top 5 most used activities
-- Orders the result by the count of products per activity in descending order
SELECT a.IdActivity AS Identificador, a.NameActivity AS Nom, a.ActivityDescription AS Descripcio, COUNT(p.NameProduct) AS Nombre_de_Cops
FROM Product p
         JOIN Activity a ON p.IdActivity = a.IdActivity
GROUP BY a.IdActivity, a.NameActivity, a.ActivityDescription
ORDER BY Nombre_de_Cops DESC
    FETCH FIRST 5 ROWS ONLY;

-- 4) Returns the credit card number and total purchase amount for the top 10 credit cards with purchases made using VISA
-- Orders the result by the total purchase amount in descending order
SELECT c.CreditCardNum AS Identificador_Targeta, SUM(p.TotalCost) AS Import_Total
FROM CreditCard c
JOIN Purchase p ON c.CreditCardNum = p.IdCard
WHERE c.CreditCardProvider LIKE '%VISA%'
GROUP BY c.CreditCardNum
ORDER BY Import_Total DESC
FETCH FIRST 10 ROWS ONLY;

-- 5) Returns the shop identifier, name, description, and total stock for shops located in Barcelona with at least 5 times the stock of the shop with the least stock across all cities
-- Orders the result by total stock in descending order
SELECT s.IdShop, s.Name AS Nom, s.ShopDescription AS Descripció, SUM(st.Stock) AS TotalEstoc
FROM Shop s
         JOIN Stores st ON s.IdShop = st.IdShop
         JOIN Club c ON c.ClubName = s.ClubName
         JOIN CITY ci ON ci.IdCity = c.IdCity
WHERE ci.CityName LIKE 'Barcelona'
GROUP BY s.IdShop, s.Name, s.ShopDescription
HAVING SUM(st.Stock) >= 5 * (
    SELECT MIN(TotalStock)
    FROM (
             SELECT IdShop, SUM(Stock) AS TotalStock
             FROM Stores
             GROUP BY IdShop
         )
)
ORDER BY TotalEstoc DESC;

-- 6) Returns the name and cost of products with cost > 350 that have never been sold
-- Orders the result by product name
SELECT p.NameProduct AS Nom, p.Cost
FROM Product p
         LEFT JOIN Purchase pu ON p.NameProduct = pu.NameProduct
WHERE p.Cost > 350 AND pu.IdPurchase IS NULL
ORDER BY p.NameProduct;

-- 7) Updates the stock of a product in a store after a purchase
-- If there's insufficient stock, inserts a warning into the WarningsList table
CREATE OR REPLACE TRIGGER UpdateStockAfterSale
AFTER INSERT ON Purchase
FOR EACH ROW
DECLARE v_stock_actual NUMBER;
BEGIN
SELECT Stock INTO v_stock_actual
FROM Stores
WHERE IdShop = :NEW.IdShop
  AND NameProduct = :NEW.NameProduct;

IF v_stock_actual >= :NEW.Units THEN
UPDATE Stores
SET Stock = Stock - :NEW.Units
WHERE IdShop = :NEW.IdShop
  AND NameProduct = :NEW.NameProduct;
ELSE
        INSERT INTO WarningsList (affected_table, error_message, id_reference, date_warning, user_warning)
        VALUES ('Purchase', 'Insufficient stock for sale', :NEW.IdPurchase, SYSDATE, 'Insufficient stock for sale');

UPDATE Stores
SET Stock = 0
WHERE IdShop = :NEW.IdShop
  AND NameProduct = :NEW.NameProduct;
END IF;
END;
/