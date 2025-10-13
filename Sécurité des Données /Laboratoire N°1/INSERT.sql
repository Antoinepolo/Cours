go
use cafe;
go

INSERT INTO Pays
VALUES(49, 'Allemagne', 'DE', 15);

-- On ne doit pas mettre l'ID car il est en auto-incrémentation (IDENTITY = auto-incrémentation)
INSERT INTO Terroir(Nom, Pays)
VALUES('Alsace', 1),
('Bordeaux', 1),
('Jura', 1);

SELECT * FROM Pays;
SELECT * FROM Terroir;