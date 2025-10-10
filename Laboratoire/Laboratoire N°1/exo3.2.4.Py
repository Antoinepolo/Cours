my_list = [32, 5, 12, 8, 3, 75, 2, 15]

list_pair = []
list_impair = []

for e in my_list:
    if e % 2 == 0:
        list_pair.append(e)
    else:
        list_impair.append(e)

print(f"Pair : {list_pair}")
print(f"Impair : {list_impair}")