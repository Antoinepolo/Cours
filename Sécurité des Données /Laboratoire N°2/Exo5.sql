GO
USE Cafe;
GO

CREATE VIEW PointDeVenteDeuxAns AS
SELECT
    -- Le nom du point de vente
    PointDeVente.nom,
    -- La plus ancienne vente
    MIN(CafeToPointDeVente.Date_Start) AS PremiereDateDeVente,
    -- Nombre total de cafés vendus dans ce point de vente
    COUNT(CafeToPointDeVente.IdCafe) AS NombreDeVente

FROM
    PointDeVente

INNER JOIN
    CafeToPointDeVente
ON
    PointDeVente.id = CafeToPointDeVente.IdPointDeVente

WHERE
    -- On ne prend que les magasins actifs, ceux où la date de fin est NULL ou ceux qui
    -- ont une date de fin supérieure à la date actuelle.
    CafeToPointDeVente.Date_End IS NULL
    OR CafeToPointDeVente.Date_End > GETDATE()

GROUP BY
    -- On regroupe les lignes du même point de vente ensemble
    PointDeVente.Nom

HAVING
    -- On ne garde que les points de vente qui ont plus de deux ans.
    MIN(CafeToPointDeVente.Date_Start) <= DATEADD(YEAR, -2, GETDATE());
GO
