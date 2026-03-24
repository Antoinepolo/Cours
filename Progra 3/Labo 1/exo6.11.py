# On récupère la note
note = input("Entrer la note (format : X/Y) : ")

# On sépare les valeurs puis on les cast
a, b = note.split("/")
a = int(a)
b = int(b)

# On calcule le pourcentage
pourcentage = (a / b) * 100

# On regarde à quelle note ça appartient
if pourcentage >= 80:
    print("A")
elif pourcentage >= 60:
    print("B")
elif pourcentage >= 50:
    print("C")
elif pourcentage >= 40:
    print("D")
else:
    print("E")