-- On fait le select avant d'avoir créer la vue
-- On peut avoir des quintuples jointures
-- 11 : Aucun retour pour Belgique, on doit utiliser l'union

-- Structure d'une jointure (si on en a plusieurs, on rajoute des joins)
	-- SELECT * FROM T1 JOIN T2 ON PKT1 = PKT2


-- Caster une valeur : CAST(T1.Nom AS NVARCHAR(255))

-- HAVING : Que pour des fonctions d'agrégation (le where est juste un filtre de ligne alors que le having est un filtre d'agrégation), on doit l'utiliser avec un GROUP BY