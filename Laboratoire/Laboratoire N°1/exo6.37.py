jours = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
mois = ["Janvier", "Févrirer", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Décembre"]
nbJourMois = [31, 28, 31,30, 31, 30, 31, 31, 30, 31, 30, 31]

jour_semaine = 3
jour_annee = 1

for m in range(12):
    for j in range(1, nbJourMois[m] + 1):
        print(f"{jours[jour_semaine]}, {j}, {mois[m]}")
        jour_semaine = (jour_semaine + 1) % 7
        jour_annee + 1