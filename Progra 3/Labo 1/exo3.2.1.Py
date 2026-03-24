t1 = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
t2 = ["Janvier", "Févirer", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]

t3 = []

for i in range(len(t1)):
    t3.append(f"{t2[i]} {t1[i]}")

for mois in t3:
    print(mois)