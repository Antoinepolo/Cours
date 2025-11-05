import traceback

try:
    print("a" + 1)
except:
    print("Error !")
    # Affiche le traceback, mais après on peut continuer le programme
    traceback.print_exc()