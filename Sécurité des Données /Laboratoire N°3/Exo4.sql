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

CREATE TABLE [CafeToPointDeVente] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[IdCafe] INTEGER,
	[IdPointDeVente] INTEGER,
	[PrixDeVente]  MONEY,
	[Date_Start] Date NOT Null,
	[Date_End] Date,
	PRIMARY KEY([id])
);
*/

CREATE PROCEDURE MettreAJourPrixVenteCafe
	@Cafe TEXT,
	@Modification FLOAT
AS
BEGIN
SET NOCOUNT ON;
	
	UPDATE CafeToPointDeVente
	SET CafeToPointDeVente.PrixDeVente = CafeToPointDeVente.PrixDeVente * (1 + @Modification / 100)
	FROM CafeToPointDeVente
	INNER JOIN Cafe ON CafeToPointDeVente.IdCafe = Cafe.id
	WHERE CAST(Nom AS NVARCHAR(MAX)) LIKE @Cafe;
END