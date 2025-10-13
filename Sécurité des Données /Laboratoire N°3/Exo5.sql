GO
USE Cafe;
GO

/*
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

CREATE TRIGGER TR_CafeToPointDeVente_Insert
ON CafeToPointDeVente
AFTER INSERT AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted
		WHERE Date_End IS NOT NULL AND Date_End <= Date_Start
	)
	BEGIN
		RAISERROR('La date de fin doit être plus grande que la date de début', 16, 1)
		ROLLBACK
		RETURN;
	END
END