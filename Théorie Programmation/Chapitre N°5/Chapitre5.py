# --------------------------------
#           EXCEPTIONS
# --------------------------------

# Toutes les erreurs en python sont des enfants de la classe BaseException

# Bloc de base
try:
    i = 1 / 0 
except ZeroDivisionError:
    print("Impossible de diviser par 0 !")

print("Hello")

# Plusieurs excepts (multi-catch)
try:
    s = 2 + "2"
    i = i / 0
    print("Hello")
except ZeroDivisionError:
    print("Erreur de division")
except TypeError:
    print("Erreur de type")

# Multi-catch, mais avec la même type d'erreur
try:
    s = 2 + "2"
except(ZeroDivisionError, TypeError):
    print(("Il y a une erreur"))

# Catch géénral de tout (mauvaise idée)
try:
    s = 2 + "2"
except: # Pas de type définit, donc on attrape tout les types d'erreurs
    print("Erreur")

# On devrait plutot préciser Exception comme type d'erreur (toujours pas recommander), mais c'est mieux que rien mettre.
# Ne rien mettre attrape même les erreurs qui devraient bloquer le programme. Par exemple, si on fait une boucle while
# infini et qu'on met un except sans rien, ça bloque le programme, ctrl + D envoie une erreur, mais cette erreur est
# donc attrapée par le catch.

# Catch général, pas une bonne idée (on peut sortir du bloc, mais on a pas le type d'erreur)
try:
    s = 2 + "2"
except Exception:
    print("Erreur classique")

# Utiliser l'objet qui représente l'exception
try:
    s = 2 + "2"
except TypeError as e: # On déclare une variable qui contient l'objet exception
    print(e)

# Lever des exception nous même (le code là est inutile)
try:
    raise ZeroDivisionError("division par zero")
except ZeroDivisionError as e:
    print(e)

# --------------------------------
#        EXCEPTION CUSTOM
# --------------------------------

# Exception custom
class CustomException(Exception):
    def __init__(self, message):
        self.message = message

    def print_message(self):
        print(self.message)

customexception = CustomException("Ceci est un message custom")
customexception.print_message()

try:
    raise(customexception)
except CustomException as e:
    e.print_message()
    # print(e) fonctionne aussi

# --------------------------------
#             ENTREES
# --------------------------------

# Bloque le programme temps qu'on n'entre rien
    #s = input("Entrez un texte : ")
    #print("Votre texte : ", s)

# Argument (qu'on pass à l'exécution)
# On utilise le module
import sys

print(type(sys.argv))
print(sys.argv[0]) # Le programme lui même

# Attention au type
    #a = int(sys.argv[1])
    #b = int(sys.argv[2])

    #print("a + b = ", a + b)

# --------------------------------
#             FICHIER
# --------------------------------

# Lecture
f = open("hello.txt") # Par défaut, c'est read (r)
line = f.readline()
print(line)
line = f.readline() # Plus rien à lire, renvoie une ligne vide
print(line)
f.close() # Libérer la mémoire, c'est une bonne pratique

# Ecriture
f = open("output.txt", "w") # On peut aussi mettre rw+ pour lire et écrire
f.write("this is an output text")
f.close()

# Le mode w efface tout le contenu du fichier

# Si on veut ajouter du texte sans écraser l'ancien, on utilise le mode a
f = open("output.txt", "a")
f.write("\nthis is a second line")
f.close()

f = open("hello.txt", "r")
for line in f:
    print(line)
f.close()