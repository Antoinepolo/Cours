# ======================
#        Curseur
# ======================

f = open("text.txt", "a+") # + : Ouverture en mode mixte (lecture/ecriture)
f.write("hello\n")
f.seek(0) # On replace au début le curseur
print(f.tell()) # Affiche ou se trouve le curseur
l = f.readline()
print(l)
f.close()

# ======================
#       Bloc With
# ======================

with open("text.txt") as f: # Fermeture automatique
    print(f.readline())

