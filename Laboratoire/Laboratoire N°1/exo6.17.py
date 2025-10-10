# Fonction
def changeCar(ch, ca1, ca2, debut = None, fin = None):
    # Si on a pas donner de début, on le met à 0
    if debut == None:
        debut = 0

    # Si on a pas donner de fin, on la met à len -1
    if fin == None:
        fin = len(ch) -1

    # On créer une chaine vide
    new_string = ""

    # On boucle sur chaque élément de la liste
    # Si c'est égal à ca2, on met ca2, sinon on met le caractère
    for i in range(len(ch)):
        if debut <= i <= fin and ch[i] == ca1:
            new_string += ca2
        else:
            new_string += ch[i]

    # On revoie
    return new_string

# Tests
phrase = "Ceci est une toute petite phrase."
print(changeCar(phrase, " ", "*"))
print(changeCar(phrase, " ", "*", 8, 12))