from sys import argv

try:
    file = open(argv[1], "x")
    text = input("Entrez votre texte : ")
    file.write(text)
    file.close()
except FileExistsError:
    print("Le fichier existe déjà !")

