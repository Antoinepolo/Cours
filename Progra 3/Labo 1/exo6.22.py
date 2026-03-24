# Fonctions
def compteCar(chaine, char):
    compteur = 0

    # On boucle et si on trouve un caractère, alors on incrémente
    for i in range(len(chaine)):
        if chaine[i] == char:
            compteur += 1
    
    # On retourne le résultat
    return compteur

# Tests
print(compteCar("ananas au jus", "a"))
print(compteCar("Gedeon est deja la", "e"))