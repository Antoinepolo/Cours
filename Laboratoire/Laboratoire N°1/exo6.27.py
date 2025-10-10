# Fonctions
def estUneMaj(char):
    return char.isupper()

# Tests

chaine = "Test"
for e in chaine:
    if estUneMaj(e):
        print("Majuscule !")
    else:
        print("Minuscule !")