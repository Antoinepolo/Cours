GO
USE Cafe;
GO

CREATE VIEW V_Cafes_Arômes_Terroirs AS
SELECT Cafe.Nom AS NomCafe, AROME.Nom AS NomArome, Terroir.Nom AS NomTerroir

FROM Cafe

INNER JOIN AromeToCafe ON AromeToCafe.Id_Cafe = Cafe.id

INNER JOIN AROME ON AromeToCafe.Id_Arome = Arome.id

INNER JOIN AromeToTypeOrigine ON AromeToTypeOrigine.Id_Arome = AROME.id

INNER JOIN Type_Origine ON AromeToTypeOrigine.Id_origine = Type_Origine.id

INNER JOIN Terroir ON Type_Origine.IdTypeRecolte = Terroir.id