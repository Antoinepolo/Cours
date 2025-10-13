GO
USE Cafe;
GO

/*
CREATE TABLE [AromeToCafe] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[Id_Arome] INTEGER NOT NULL,
	[Id_Cafe] INTEGER NOT NULL,
	PRIMARY KEY([id])
);
GO
*/

CREATE PROCEDURE AssocierAromeAuCafe
	@Id_Arome INTEGER,
	@Id_Cafe INTEGER
AS
BEGIN
SET NOCOUNT ON;

	-- On vérifie que l'association existe
	IF EXISTS (SELECT 1 FROM AromeToCafe WHERE Id_Arome = @Id_Arome AND Id_Cafe = @Id_Cafe)
	BEGIN
		RAISERROR('La liaison existe déjà', 10, 1)
		RETURN;
	END
	
	-- On insert
	INSERT INTO AromeToCafe(Id_Arome, Id_Cafe)
	VALUES (@Id_Arome, @Id_Cafe);
END