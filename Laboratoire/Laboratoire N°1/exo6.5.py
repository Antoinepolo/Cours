my_list = []

# Boucle principale
while True:
    entree = input("> ")
    if entree == "":
        # Si on détecte un entrer (vide) alors on sort
        break
    else:
        # On ajoute la valeur
        my_list.append(entree)
        print("Valeur ajouter avec succès !")

# On affiche la liste
print(my_list)