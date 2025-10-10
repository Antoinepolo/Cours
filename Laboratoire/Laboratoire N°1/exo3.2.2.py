t2 = ["Janvier", "Févirer", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]

chaine = ""

for e in t2:
    chaine = chaine + e + " "

print(chaine)

# Autres méthodes
print(" ".join(t2))

for e in t2:
    print(e + " ", end="")
print()