import math

n = int(input("Nombre : "))

if n >= 0:
    res = math.sqrt(n)
    print(f"Racine de {n} = {res}")
else:
    print("Veuillez entrer un nombre positif (ou nul)")