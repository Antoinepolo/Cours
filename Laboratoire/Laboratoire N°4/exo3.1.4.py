# Lit tout le fichier
file = open("file.txt")
print(file.read())
file.close()

# Lit 5 caractères
file = open("file.txt")
print(file.read(5))
file.close()

# Déplace le curseur à la case indiquée
file = open("file.txt")
file.seek(2)
print(file.readline())
file.close()

# Affiche la position du curseur
file = open("file.txt")
file.read(5)
print(file.tell())
file.close()