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

CREATE PROCEDURE MettreAJourPrixVenteConseille
	@Nom TEXT,
	@PrixVenteConseillé MONEY
AS
BEGIN
	IF @PrixVenteConseillé <= 0
	BEGIN
		PRINT 'Erreur, le prix doit être plus grand que 0'
	END
	ELSE
	BEGIN
		UPDATE Cafe
		SET PrixVenteConseillé = @PrixVenteConseillé
		WHERE CAST(Nom AS NVARCHAR(MAX)) LIKE @Nom;
	END
END