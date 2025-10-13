go
use Cafe;
go

-- On va considérer que l'intensité est élevée à partir de 5
CREATE VIEW Intensite_Elevee AS
SELECT *
FROM Cafe
WHERE Intensité > 5;
GO -- Permet de séparer les blocs d'instructions (sinon on a une erreur)

SELECT * FROM Intensite_Elevee;