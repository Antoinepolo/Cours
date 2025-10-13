GO
USE Cafe;
GO

-- EXO 1
EXEC AjouterNouveauCafe @Nom = 'Café de pas d idée', @Intensité = 1, @Description = 'Coucou', @PrixVenteConseillé = 4.30, @Torréfaction = 1;

-- EXO 2
EXEC MettreAJourPrixVenteConseille @Nom = 'Pacamara', @PrixVenteConseillé = 13.50;

-- EXO 3
EXEC AssocierAromeAuCafe @Id_Arome = 7, @Id_Cafe = 10;
EXEC AssocierAromeAuCafe @Id_Arome = 3, @Id_Cafe = 11;

-- EXO 4
EXEC MettreAJourPrixVenteCafe @Cafe = 'Café Parisien', @Modification = -20;

-- EXO 5 (Génère erreur si pas commenter)
-- INSERT INTO CafeToPointDeVente(IdCafe, IdPointDeVente, PrixDeVente, Date_Start, Date_End)
-- VALUES(1, 1, 4.30, '2025-10-13', '2025-10-12');

-- EXO 6
UPDATE Cafe
SET Intensité = 11
WHERE id = 1;

/*
CREATE TABLE [Cafe] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[Nom] TEXT,
	[Intensité] SMALLINT,
	[Description] TEXT,
	[PrixVenteConseillé] MONEY,
	[Torréfaction] INTEGER,
	PRIMARY KEY([id])
);
*/


-- SELECT
SELECT * FROM Cafe;
SELECT * FROM AromeToCafe;
SELECT * FROM CafeToPointDeVente;