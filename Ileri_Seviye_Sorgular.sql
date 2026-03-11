/* ============================================================
ADVANCED SQL EXAMPLES - NORTHWIND DATABASE
=============================================================
This file contains advanced T-SQL examples on database automation and reporting.

*/

-- 1. AUTOMATIC STOCK UPDATE (TRIGGER)
-- Scenario: Automatically reduces the stock quantity of a product when a sale is made.

/* ============================================================
GELİŞMİŞ SQL ÖRNEKLERİ - NORTHWIND VERİTABANI
============================================================
Bu dosya, veritabanı otomasyonu ve raporlama üzerine 
ileri seviye T-SQL örneklerini içermektedir.
*/

-- 1. OTOMATİK STOK GÜNCELLEME (TRIGGER)
-- Senaryo: Bir satış yapıldığında ürünün stok miktarını otomatik düşürür.
GO
CREATE TRIGGER TR_StokGuncelle
ON [Order Details]
AFTER INSERT
AS
BEGIN
    UPDATE Products
    SET UnitsInStock = UnitsInStock - inserted.Quantity
    FROM Products
    INNER JOIN inserted ON Products.ProductID = inserted.ProductID;
    
    PRINT 'Stok miktarı satış sonrası otomatik olarak güncellendi.';
END
GO
-- 2. DYNAMIC SALES REPORT (STORED PROCEDURE)
-- Scenario: Retrieves the total turnover and number of orders between two specific dates. -- Usage: EXEC sp_DatedSalesReport '1996-01-01', '1997-01-01'
  
-- 2. DİNAMİK SATIŞ RAPORU (STORED PROCEDURE)
-- Senaryo: Belirli iki tarih arasındaki toplam ciroyu ve sipariş sayısını getirir.
-- Kullanımı: EXEC sp_TarihliSatisRaporu '1996-01-01', '1997-01-01'
GO
CREATE PROCEDURE sp_TarihliSatisRaporu
    @BaslangicTarihi DATETIME,
    @BitisTarihi DATETIME
AS
BEGIN
    SELECT 
        FORMAT(SUM(UnitPrice * Quantity * (1 - Discount)), 'C', 'en-US') AS Toplam_Ciro,
        COUNT(OrderID) AS Toplam_Siparis_Sayisi
    FROM [Order Details]
    INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
    WHERE Orders.OrderDate BETWEEN @BaslangicTarihi AND @BitisTarihi;
END
GO
