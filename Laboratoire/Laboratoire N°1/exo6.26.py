# Fonctions
def estUnChiffre(char):
    return char in "0123456789"

# Tests
chaine = "0Test123"
for e in chaine:
    if estUnChiffre(e):
        print("C'est un chiffre")
    else:
        print("Ce n'est pas un chiffre")