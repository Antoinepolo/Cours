go
use cafe;
go

SELECT
	AROME.id AS Arome,
	COUNT(AromeToCafe.Id_Cafe) AS NombreCafe
FROM
	AROME
LEFT JOIN
	AromeToCafe ON AROME.id = AromeToCafe.Id_Arome
GROUP BY -- Pour que count fonctionne, on doit regroupper les aromes
	AROME.id;

-- On peut voir group by comme si on créer une liste (en python) qui regroupe toutes les données qui on un point en commun
-- ici, c'est l'id de l'arome