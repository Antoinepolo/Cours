x = 0
y = 1

for i in range(0, 10):
    print(x)                # Exemple pour x = 3, b = 5
    temps = x + y           # On créer une variable temporaire avec x + y (donc 8)
    x = y                   # On met y dans x (3 devient 5)
    y = temps               # On assigne la valeur de temps à y (donc 8)
                            # Le prochaine calcul aura donc x = 5 et y = 8