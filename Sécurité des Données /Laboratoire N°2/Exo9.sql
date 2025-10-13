USE Cafe;

SELECT Pays.Nom, COUNT(DISTINCT AROME.id) AS NbArome
FROM Pays

INNER JOIN Ville ON Ville.IdPays = Pays.id

INNER JOIN Adresse ON Adresse.IdVille = Ville.id

INNER JOIN PointDeVente ON PointDeVente.Adresse = Adresse.id

INNER JOIN CafeToPointDeVente ON CafeToPointDeVente.IdPointDeVente = PointDeVente.id

INNER JOIN Cafe ON CafeToPointDeVente.IdCafe = Cafe.id

INNER JOIN AromeToCafe ON Cafe.id = AromeToCafe.Id_Cafe

INNER JOIN AROME ON AromeToCafe.Id_Arome = AROME.id

GROUP BY Pays.Nom

HAVING COUNT(DISTINCT AROME.id) > 3;