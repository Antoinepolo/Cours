GO
USE Cafe;
GO

SELECT DISTINCT CAST(Cafe.Nom AS VARCHAR(100)) AS NomCafe

FROM Cafe

INNER JOIN CafeToPointDeVente ON Cafe.Id = CafeToPointDeVente.IdCafe

INNER JOIN PointDeVente ON CafeToPointDeVente.IdPointDeVente = PointDeVente.Id

INNER JOIN Adresse ON PointDeVente.Adresse = Adresse.Id

INNER JOIN Ville ON Adresse.IdVille = Ville.Id

WHERE Ville.Id IN (

    SELECT Ville.Id

    FROM Cafe

    INNER JOIN CafeToPointDeVente ON Cafe.Id = CafeToPointDeVente.IdCafe

    INNER JOIN PointDeVente ON CafeToPointDeVente.IdPointDeVente = PointDeVente.Id

    INNER JOIN Adresse ON PointDeVente.Adresse = Adresse.Id

    INNER JOIN Ville ON Adresse.IdVille = Ville.Id

    WHERE CAST(Cafe.Nom AS VARCHAR(100)) = 'Espresso Roma'
)
AND CAST(Cafe.Nom AS VARCHAR(100)) <> 'Espresso Roma';