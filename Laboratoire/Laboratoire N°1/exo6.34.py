mutliplicateurs = [2, 3, 5, 7, 11, 13, 17, 19]

for n in mutliplicateurs:
    # On prend le multiplicateur et on le mutliplie (de 1 à 15 (+1))
    table = [n * i for i in range(1, 16)]

    print(table)