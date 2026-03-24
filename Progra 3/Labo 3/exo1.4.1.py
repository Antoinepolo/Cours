# On test
try:
    fic = open("fic.txt")

# Le fichier n'existe pas
except FileNotFoundError:
    print("Erreur : le fichier n'existe pas.")

# On a une autre erreur
except Exception as e:
    print("Erreur : ", e)

# A la fin on ferme (si il existe)
finally:
    if fic is not None:
        fic.close()