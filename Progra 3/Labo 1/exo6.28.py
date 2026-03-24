# Fonctions
def chaineList(chaine):
    return chaine.split()

# Tests
chaine = "Coucou tout le monde"
print(chaine, type(chaine))
chaine = chaineList(chaine)
print(chaine, type(chaine))