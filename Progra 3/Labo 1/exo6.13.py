note = 0
listes_notes = []

while note >= 0:
    note = int(input("Entrer la note : "))

    # On quitte si inférrieur à 0
    if note < 0:
        break

    # On ajoute la valeur
    listes_notes.append(note)

    # On affiche les infos
    print(f"Nombre de notes : {len(listes_notes)}")
    print(f"Maximum : {max(listes_notes)}")
    print(f"Minimum : {min(listes_notes)}")
    print(f"Moyenne : {sum(listes_notes) / len(listes_notes)}")