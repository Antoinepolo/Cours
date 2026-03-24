# Fonctions
def estUneMaj(char):
    return char.isupper()

def compterMaj(chaine):
    nb_maj = 0

    # On boucle sur chaque caractère et appel la fonction d'au dessus
    for c in chaine:
        if estUneMaj(c):
            nb_maj += 1

    return nb_maj

# Tests
chaine = "Coucou tout le MondE"

print(compterMaj(chaine))