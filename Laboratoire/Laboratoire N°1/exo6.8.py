nom = input("Nom : ")
sexe = input("Homme (M), Femme (F) : ")

if sexe == "M":
    print(f"Cher Moniseur {nom}")
elif sexe == "F":
    print(f"Chère Mademoiselle {nom}")
else:
    print("Sexe invalide")