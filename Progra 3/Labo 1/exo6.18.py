# Fonction
def eleMax(list, debut = None, fin = None):
    # Si on a pas de début
    if debut == None:
        debut = 0

    # Si on a pas de fin
    if fin == None:
        fin = len(list) - 1

    # Nouvelle list
    new_list = []

    # On créer une nouvelle list
    for i in range(len(list)):
        if debut <= i <= fin:
            new_list.append(list[i])

    # On return le max de la nouvelle list
    return max(new_list)

# Tests
serie = [9, 3, 6, 1, 7, 5, 4, 8, 2]
print(eleMax(serie))
print(eleMax(serie, 2, 5))
print(eleMax(serie, 2))
print(eleMax(serie, fin = 3, debut= 1))