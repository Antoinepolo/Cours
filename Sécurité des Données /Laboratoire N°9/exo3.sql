-- Affichez les noms et les prénoms des personnages ayant 16 ans
-- avec le premier utilisateur.

GO
USE DB_SecuData_Audit;
GO

SELECT nom, prenom
FROM Personne
WHERE age = 16;