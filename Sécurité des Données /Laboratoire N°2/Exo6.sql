GO
USE Cafe;
GO

CREATE VIEW NombreCafeParIntensite AS
SELECT
	Cafe.Intensité,
	Torrefaction.Nom,
	-- Nombre de cafés ayant cette intensité et cette torréfaction
	COUNT(Cafe.id) AS NombreDeCafes

FROM
	Cafe

INNER JOIN
	Torrefaction

ON
	Cafe.Torréfaction = Torrefaction.id

GROUP BY
	Cafe.Intensité,
	Torrefaction.Nom;