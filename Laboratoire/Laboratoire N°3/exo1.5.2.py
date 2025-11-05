import sys

try:
    sys.exit()
except SystemExit:
    print("Erreur")

# On ne veut pas attraper les erreurs comme sysexit (fin de prog) ou keyboard interupt