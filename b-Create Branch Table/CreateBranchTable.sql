--We create Branch table using CityPopulation and Regions Table
Declare @k as int
SET @k=1
While @k<82
BEGIN
DECLARE @City as varchar(100)
DECLARE @Region as varchar(100)
DECLARE @Location as varchar (100)

SELECT @City=City from CityPopulation WHERE ID=@k
SELECT @Region=Region FROM Regions WHERE City=@City
SET @City=@City+' '+'Branch'
SET @Location=LEFT(@City,CHARINDEX(' ',@City))


INSERT INTO Branch(Branch_Name,Region,Location_)
VALUES(@City,@Region,@Location)
SET @k=@k+1

END 












