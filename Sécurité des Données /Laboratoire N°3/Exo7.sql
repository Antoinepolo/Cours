GO
USE Cafe;
GO

CREATE TABLE Historique (
	ancienne_valeur DEC(4,2)
	nouvelle_valeur DEC(4, 2)s
);

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

CREATE TRIGGER TR_Cafe_UpdatePrix
ON Cafe
AFTER UPDATE AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted
		WHERE Intensité NOT BETWEEN 1 AND 10
	)
	BEGIN
		RAISERROR('L intensite du café doit se trouve entre 1 et 10.', 16, 1)
		ROLLBACK
		RETURN;
	END
END