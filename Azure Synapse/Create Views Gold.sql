--------------------------------------------------
-- CREATE VIEW CALENDAR
--------------------------------------------------
CREATE VIEW gold.calendar
AS
SELECT * FROM
    OPENROWSET(
                BULK 'https://adlsgen2adventure11.blob.core.windows.net/silver/AdventureWorks_Calendar/',
                FORMAT = 'PARQUET'
    ) AS QUERY1


--------------------------------------------------
-- CREATE VIEW CUSTOMERS
--------------------------------------------------
CREATE VIEW gold.customers
AS
SELECT * FROM
    OPENROWSET(
                BULK 'https://adlsgen2adventure11.blob.core.windows.net/silver/AdventureWorks_Customers/',
                FORMAT = 'PARQUET'
    ) AS QUERY1

--------------------------------------------------
-- CREATE VIEW PROSUB
--------------------------------------------------
CREATE VIEW gold.prosub
AS
SELECT * FROM
    OPENROWSET(
                BULK 'https://adlsgen2adventure11.blob.core.windows.net/silver/AdventureWorks_ProductSubcategory/',
                FORMAT = 'PARQUET'
    ) AS QUERY1

--------------------------------------------------
-- CREATE VIEW PRODUCT
--------------------------------------------------
CREATE VIEW gold.product
AS
SELECT * FROM
    OPENROWSET(
                BULK 'https://adlsgen2adventure11.blob.core.windows.net/silver/AdventureWorks_Product/',
                FORMAT = 'PARQUET'
    ) AS QUERY1

--------------------------------------------------
-- CREATE VIEW RETURNS
--------------------------------------------------
CREATE VIEW gold.ret
AS
SELECT * FROM
    OPENROWSET(
                BULK 'https://adlsgen2adventure11.blob.core.windows.net/silver/AdventureWorks_Returns/',
                FORMAT = 'PARQUET'
    ) AS QUERY1

--------------------------------------------------
-- CREATE VIEW SALES
--------------------------------------------------
CREATE VIEW gold.sales
AS
SELECT * FROM
    OPENROWSET(
                BULK 'https://adlsgen2adventure11.blob.core.windows.net/silver/AdventureWorks_Sales/',
                FORMAT = 'PARQUET'
    ) AS QUERY1


--------------------------------------------------
-- CREATE VIEW TERRITOTIES
--------------------------------------------------
CREATE VIEW gold.territories
AS
SELECT * FROM
    OPENROWSET(
                BULK 'https://adlsgen2adventure11.blob.core.windows.net/silver/AdventureWorks_Territories/',
                FORMAT = 'PARQUET'
    ) AS QUERY1




