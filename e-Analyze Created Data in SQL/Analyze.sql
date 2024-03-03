--These descriptions are both Turkish and English

--Marmara B�lgesinde T�ketici kategorisinde en fazla sat���n oldu�u ay
--The month with the highest sales in the Personel category in the Marmara Region
 
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Region='Marmara B�lgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC


--Marmara B�lgesinde En fazla Sat���n Oldu�u ay ve Kategori
--Month and Category with the Most Sales in the Marmara Region
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Region='Marmara B�lgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC

--Akdeniz B�lgesinde T�ketici kategorisinde her ay�n toplam sat��lar�
--Total sales of each month in the Personal category in the Akdeniz Region
SELECT  DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Region='Akdeniz B�lgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC


--istanbul �ubesinde T�ketici Kategorisinde En Fazla Sat���n Yap�ld��� Ay
--The Month with the Most Sales in the Personal Category in the Istanbul Branch
SELECT TOP 1  Branch_Name, DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Branch_Name='�stanbul Branch'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales DESC



--�stanbul �ubesinde T�ketici Kategorisinde En Az Sat�� Yapt��� Ay
--Month with Least Sales in Personal Category in Istanbul Branch
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Branch_Name,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Branch_Name='�stanbul Branch'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales ASC

--Marmara B�lgesinde Ta��t Kategorisinde En Az Sat���n Yap�ld��� �ube ve Ay
--Branch and Month with the Least Sales in the Auto Category in the Marmara Region
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Branch_Name,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Auto' AND Region='Marmara B�lgesi'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales ASC

--Haziran Ay�nda Do�u Anadolu B�lgesinde En Fazla Sat�� Yapan �ube
--The Branch with the Most Sales in the Do�u Anadolu Region in June
SELECT TOP 1 Branch_Name,Region,DATENAME(MONTH,Date_) AY,SUM(Sales) Sales

FROM Credits KD
JOIN Branch S ON S.Sube_ID=KD.Sube_ID
WHERE DATENAME(MONTH,Date_)='June' and Region='DO�U ANADOLU B�LGES�'
GROUP BY Branch_Name,Region,DATENAME(MONTH,Date_)
ORDER BY Sales DESC

--G�neydo�u Anadolu B�lgesinde Her Ay�n En �ok Sat�� Yapan �ubesi
--The Most Sales Branch of Every Month in the G�neydo�u Anadolu Region
SELECT Branchs,Dates,Sales
FROM
( SELECT Branch_Name Branchs,Date_ Dates,SUM(Sales) as Sales,
RANK () over (partition by Date_ Order By SUM(Sales) DESC )rn
FROM Credits KD
JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE MONTH(Date_) between 1 and 12 and Region='G�neydo�u Anadolu B�lgesi'
GROUP BY Branch_Name,Date_
)t
WHERE rn<=1






--B�lgelerin Sat�� Toplamlar�
--Total Sales of Regions
SELECT Region,SUM(Sales) SumSales
FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
GROUP BY Region
ORDER BY SumSales DESC


--B�lgelerin Ocak Ay�ndaki Sat�� Toplamlar�
--Total Sales of the Regions in January
SELECT Region,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE DATENAME(MONTH,Date_)='January'
GROUP BY Region
ORDER BY SumSales DESC


--Her �ubenin t�ketici, ta��t, konut kredisi sat��lar�n�n ayl�k sat�� toplamlar�n�n 12 ayl�k ortalamas�
--The monthly average aggregated sales for the personal,auto,mortgage loans of each Branch over a 12 month period.
SELECT  Branch_Name,AVG(SumSales) AvgSumSales FROM
( SELECT Branch_Name,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
GROUP BY Branch_Name,DATENAME(MONTH,Date_) 
) T
GROUP BY Branch_Name
ORDER BY  2 DESC

--Marmara B�lgesindeki �ubelerin Ayl�k Sat�� Toplamlar�n�n 12 Ayl�k Ortalamas�
--The monthly average aggregated sales for the Marmara Region Branches over a 12 month period
SELECT  Branch_Name,Region,AVG(SumSales) AVGSumSales FROM
( SELECT Branch_Name,Region,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE Region='Marmara B�lgesi'
GROUP BY Branch_Name,DATENAME(MONTH,Date_),Region
) T
GROUP BY Branch_Name,Region
ORDER BY  AVGSumSales DESC




--B�lge baz�nda  �ubelerin t�ketici, ta��t, konut kredisi sat��lar�n�n ayl�k toplamlar�n�n 12 ayl�k ortalamas�
--The monthly average aggregated sales for the Regions over a 12 month period.
SELECT  Region,AVG(SumSales) AvgSumSales FROM
( SELECT Region,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID

GROUP BY Region,DATENAME(MONTH,Date_) 

) T
GROUP BY Region
ORDER BY  2 DESC

--G�NEYDO�U ANADOLU B�LGES�'ndeki �ubelerin kategori sat��lar�n�n her ay ortalamas�
--Average of category sales of Branches in G�neydo�u Anadolu Region for each month

SELECT Branch_Name,Region,DATENAME(MONTH,Date_) AY,AVG(Sales) Ortalama

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE Region='G�NEYDO�U ANADOLU B�LGES�'
GROUP BY Branch_Name,DATENAME(MONTH,Date_),Region
ORDER BY Branch_Name DESC



--�stanbul �ubesinin t�ketici, ta��t, konut kategorisi sat��lar�n�n her ay i�in ortalamas�
--Average of Istanbul Branch's consumer, vehicle and housing category sales for each month
SELECT Branch_Name,DATENAME(MONTH,Date_) AY,AVG(Sales) AvgSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE Branch_Name='�stanbul Branch'
GROUP BY Branch_Name,DATENAME(MONTH,Date_)
ORDER BY 3 DESC

