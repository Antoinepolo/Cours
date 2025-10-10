# Fonctions
def estUneMaj(char):
    return char.isupper()

def chaineList(chaine):
    return chaine.split()

# Tests
chaine = "Coucou tout le Monde"
chaine = chaineList(chaine)

mot_commence_par_maj = []

for mot in chaine:
    if estUneMaj(mot[0]):
        mot_commence_par_maj.append(mot)

print(mot_commence_par_maj)