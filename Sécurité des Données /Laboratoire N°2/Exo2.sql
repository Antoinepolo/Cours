go
use cafe;
go

SELECT
	Cafe.Nom AS NomCafe,
	AROME.Nom as NomArome
FROM
	Cafe
LEFT JOIN
	AromeToCafe ON Cafe.id = AromeToCafe.Id_Cafe
LEFT JOIN
	AROME ON AromeToCafe.Id_Arome = AROME.id;