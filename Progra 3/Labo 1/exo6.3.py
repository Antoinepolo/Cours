langue = input("Langue (f/n/e) : ")

if langue == "f":
    print("Français")
elif langue == "n":
    print("Nederlands")
elif langue == "e":
    print("English")
else:
    print("Erreur")

# Avec la fonction
def char_to_strings(argument):
    switcher = {
        "f": "Français",
        "n": "Nederlands",
        "e": "English",
    }
    return switcher.get(argument, "Erreur")

print(char_to_strings(langue))