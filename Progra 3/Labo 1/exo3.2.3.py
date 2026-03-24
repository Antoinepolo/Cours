my_list = [32, 5, 12, 8, 3, 75, 2, 15]

maxi = 0

for i in range(len(my_list)):
    if my_list[i] > maxi:
        maxi = my_list[i]

print(maxi)

# Autre méthode

print(max(my_list))