ma_chaine = "Polo"

nouvelle_chaine = ""

for carac in ma_chaine:
    nouvelle_chaine += carac + '*'

nouvelle_chaine = nouvelle_chaine[:-1]

print(nouvelle_chaine)