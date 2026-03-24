nom = ["Jean-Michel", "Marc", "Vanessa", "Anne", "Maximilien", "Alexendre-Benoit", "Louise"]
my_list = []

# Pour chaque élément, on ajoute à my_list le nom et la longueur
for e in nom:
    my_list.append(f"{e} {len(e)}")

print(my_list)

# Autre méthode avec des list comprehension

my_list = [f"{e} {len(e)}" for e in nom]
print(my_list)

# On peut aussi mettre en forme de tuple pour facilité le traitement

my_list = [(e, len(e)) for e in nom]
print(my_list)