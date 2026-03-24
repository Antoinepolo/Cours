my_list = ["Jean", "Maximilien", "Brigitte", "Sonia", "Jean-Pierre", "Sandra"]

court_nom = []
long_nom = []

for name in my_list:
    if len(name) < 6:
        court_nom.append(name)
    else:
        long_nom.append(name)

print(f"Long nom : {long_nom}")
print(f"Court nom : {court_nom}")