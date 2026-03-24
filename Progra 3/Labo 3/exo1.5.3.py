import warnings

try:
    warnings.warn("Test")
except:
    print("Erreur")

# Warning est juste un avertissement, pas une exception, ça sert a avertir sans couper le prog
# Par exemple ou peut faire un warn dans une fonction obsolète pour dire qu'elle l'est