USE Cafe;
GO

CREATE VIEW CafeItalienVentuEn2021 AS
SELECT Cafe.Nom

FROM Cafe

INNER JOIN CafeToPointDeVente ON Cafe.Id = CafeToPointDeVente.IdCafe

INNER JOIN PointDeVente ON CafeToPointDeVente.IdPointDeVente = PointDeVente.id

INNER JOIN Adresse ON PointDeVente.Adresse = Adresse.id

INNER JOIN Ville ON Adresse.IdVille = Ville.id

INNER JOIN Pays ON Ville.idPays = Pays.id

WHERE Pays.Nom = 'Italie' AND CafeToPointDeVente.Date_Start BETWEEN '2021-01-01' AND '2021-12-31';