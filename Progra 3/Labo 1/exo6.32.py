# On affiche tout les caractères de 128 à 256 (257 pour inclure 256)
for i in range(128, 257):
    # On affiche et le numéro et on cast la valeur en char
    print(f"{i} {chr(i)}")

# On affiche toutes les lettres et leur miniuscule (lettre + 32)
for i in range(128, 257):
    print(f"{i} : {chr(i)}, {i + 32} : {chr(i + 32)}")

        # La règle reste vrai pour les caractères français