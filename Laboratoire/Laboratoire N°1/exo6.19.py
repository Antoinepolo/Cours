# Fonction
def decouperEtInverser(chaine):
    # On créer un boucle qui va d'indice en incrément de 5 et on slice la chaine de i à i + 5 (exclu)
    morceaux = [chaine[i:i+5] for i in range(0, len(chaine), 5)]

            # print(morceaux)

    # On reverse la list
    morceaux.reverse()

    # On join la liste en un seul morceau
    chaine_inverse = "".join(morceaux)

    return chaine_inverse


# Tests
my_string = "Une phrase vraiment longue avec des accents éèîö"
print(decouperEtInverser(my_string))