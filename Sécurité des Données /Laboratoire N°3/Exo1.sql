GO
USE Cafe;
GO

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

CREATE PROCEDURE AjouterNouveauCafe
	@Nom TEXT,
	@Intensité SMALLINT,
	@Description TEXT,
	@PrixVenteConseillé MONEY,
	@Torréfaction INTEGER
AS
BEGIN
	-- IF NOT EXISTS (SELECT 1 FROM Cafe WHERE CAST(Nom AS NVARCHAR(100)) = @Nom) -> On ne peux pas comparer 2 TEXT
	-- car ils ne sont plus supportés
	-- 1 -> Equivalent de NULL, on veut juste voir si la requête retourne un truc ou pas
	IF NOT EXISTS (SELECT 1 FROM Cafe WHERE CAST(Nom AS NVARCHAR(MAX)) LIKE @Nom)
	BEGIN
		INSERT INTO Cafe(Nom, Intensité, Description, PrixVenteConseillé, Torréfaction)
		VALUES (@Nom, @Intensité, @Description, @PrixVenteConseillé, @Torréfaction);
	END
	ELSE
	BEGIN
		PRINT 'Ce café existe déjà';
	END
END