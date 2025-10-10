# Fonction
def trouve(chaine, char, debut = 0):
    # On boucle sur la chaine avec i, et on compare les caractères

    for i in range(debut, len(chaine)):
        if chaine[i] == char:
            return i

    # Si on arrive ici, c'est qu'aucune correspondance n'a été trouvée, alors on retourne -1
    return -1

# Tests
print(trouve("Juliette & Roméo", "&"))
print(trouve("Juliette & Roméo", "x"))
print(trouve("Juliette & Roméo", "é"))
print(trouve("Cesar & Cleopatre", "r", 5))