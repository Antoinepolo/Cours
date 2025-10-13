go
use cafe;
go

SELECT -- On séléctionne les données (avec des alias)
    Cafe.Nom AS NomCafe,
    Type_Origine.Nom AS NomTypeOrigine
FROM -- On choisit la table principale
    Cafe
JOIN -- On fait le lien avec la table CafeToTypeOrigine
    CafeToTypeOrigine ON Cafe.id = CafeToTypeOrigine.Id_Cafe
JOIN -- On fait le lien de CafeToTypeOrigine et Type_Origine
    Type_Origine ON CafeToTypeOrigine.Id_TypeOrigine = Type_Origine.id;


-- Type_Origine (Nom)
-- Cafe (Nom)