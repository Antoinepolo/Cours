# Si divisible par 4 -> bissextile
# Si multiple de 100 -> pas bissextile (sauf si multiple de 400)

annee = int(input("Année : "))

if annee % 4 == 0:
    # Annee divible par 4
    if annee % 100 == 0:
        # Non bissextile (sauf si on peut diviser par 400)
        if annee % 400 == 0:
            print("Année bissextile")
        else:
            print("Année non bissextile")
    else:
        print("Année bissextile")
    
else:
    print("Année non bissextile")