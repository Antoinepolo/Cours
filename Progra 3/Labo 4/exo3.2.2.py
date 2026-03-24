from sys import argv

# Remplace le texte quand on écrit
# Si le fichier n'existe pas, il le créer
file = open(argv[1], "w")
text = input("Entrez votre texte : ")
file.write(text)
file.close()