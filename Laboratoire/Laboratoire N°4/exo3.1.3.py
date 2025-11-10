file = open("file.txt")
# Lit une ligne
print(file.readline())
# Lit toutes les lignes et retournes sous formes de list
print(file.readlines())
file.close()