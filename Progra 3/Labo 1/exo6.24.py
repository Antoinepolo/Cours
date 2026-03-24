def calculerNbMot(chaine):
    # On split sur les espaces -> On créer une listes avec chaque mots
    mots = chaine.split()

    # On renvoie la longueur de la liste
    return len(mots)

print(calculerNbMot("Ceci est une chaine de sept mots"))