go
use cafe;
go

SELECT Nom, Intensité, PrixVenteConseillé
FROM Cafe;

SELECT COUNT(*)
AS 'Nombre de cafe'
FROM Cafe;

SELECT Nom
FROM Cafe
WHERE Intensité >= 5;

SELECT Intensité, COUNT(*)
AS 'Nombre de cafe'
FROM Cafe
GROUP BY Intensité;

SELECT Nom
FROM Cafe
WHERE PrixVenteConseillé BETWEEN 5 AND 10;

SELECT Nom, PrixVenteConseillé
FROM Cafe
ORDER BY PrixVenteConseillé DESC;

SELECT COUNT(DISTINCT Id_Arome) AS 'Nombre d aromes'
FROM AromeToCafe;

SELECT Nom
FROM Cafe
Where Description LIKE '%Bio%';

SELECT AVG(PrixVenteConseillé)
AS 'Prix moyen'
FROM Cafe;