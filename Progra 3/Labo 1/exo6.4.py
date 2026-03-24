# Fonction pour convertir
def metre_to_kilometre(n):
    return n * 3.6

# Entrées
choix = input("(1) m/s   (2) km/h : ")
vitesse = int(input("Vitesse : "))

# Si on utilise des m/s on fait la conversion
if choix == 1:
    vitesse = metre_to_kilometre(vitesse)

# Calcul v(miles) = v(km/h) / 1.609
vitesse = vitesse / 1.609
print(f"Votre vitesse est de {vitesse:.2f} miles/h")