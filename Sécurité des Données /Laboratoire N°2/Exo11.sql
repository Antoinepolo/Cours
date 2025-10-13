GO
USE Cafe;
GO

SELECT Cafe.Nom, PointDeVente.Nom

FROM Cafe

INNER JOIN CafeToPointDeVente ON CafeToPointDeVente.IdCafe = Cafe.id

INNER JOIN PointDeVente ON CafeToPointDeVente.IdPointDeVente = PointDeVente.id

INNER JOIN Adresse ON PointDeVente.Adresse = Adresse.id

INNER JOIN Ville ON Adresse.IdVille = Ville.id

INNER JOIN Pays ON Adresse.IdVille = Pays.id

WHERE Pays.Nom = 'France';