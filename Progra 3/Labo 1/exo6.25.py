def compteNbE(chaine):
    compteur = 0

    for lettre in chaine:
        if lettre in ["e", "é", "è", "ë", "ê"]:
            compteur += 1
    
    return compteur

print(compteNbE("test éèëê"))