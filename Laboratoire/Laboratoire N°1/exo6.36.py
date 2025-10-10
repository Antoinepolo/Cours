my_list = [1, 4, 3, 9, 0, 1, 2, 9]

new_list = []

for e in my_list:
    if e not in new_list:
        new_list.append(e)

print(new_list)