# On affiche tout les caractères affichable
for i in range(32, 127):
    # On affiche et le numéro et on cast la valeur en char
    print(f"{i} {chr(i)}")

# On affiche toutes les lettres et leur miniuscule (lettre + 32)
for i in range(65, 91):
    print(f"{i} : {chr(i)}, {i + 32} : {chr(i + 32)}")