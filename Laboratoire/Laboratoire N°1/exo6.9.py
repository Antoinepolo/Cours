a = int(input("Valeur de a : "))
b = int(input("Valeur de b : "))
c = int(input("Valeur de c : "))

if a + b > c and a + c > b and b + c > a:
    # Triangle équilatérale
    if a == b == c:
        print("Triangle équilatérale")
    
    # Triangle isocèle
    elif a == b or a == c or b == c:
        print("Triangle isocèle")

    # Triangle quelconque
    else:
        print("Triangle quelconque")

    # Triangle rectangle
    if c**2 == a**2 + b**2 or a**2 == b**2 + c**2 or b**2 == a**2 + c**2:
        print("Triangle rectangle")

# Si pas un triangle
else:
    print("Ce n'est pas un triangle")