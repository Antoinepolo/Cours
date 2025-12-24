-- Ajoutez une ligne dans la table Personne avec le second
-- utilisateur et supprimez la ligne avec l’ID = 1.

GO
USE DB_SecuData_Audit;
GO

INSERT INTO Personne
VALUES(11, 'Jean', 'Pierre', 18, 'Namur');

DELETE FROM Personne
WHERE id = 1;