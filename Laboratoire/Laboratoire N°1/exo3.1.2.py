ma_chaine = "Une chaine avec quelques 'e'"

nb_e = 0

for carac in ma_chaine:
    if carac == 'e':
        nb_e += 1

print("Dans la chaine il y a {} fois le caractère 'e'".format(nb_e))