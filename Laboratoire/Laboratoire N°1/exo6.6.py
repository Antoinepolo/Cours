a = int(input("Borne A : "))
b = int(input("Borne B : "))

n = 0

# On boucle de a à b (inclu)
for i in range(a, b + 1):
    # Si le résultat du modulo est égal à 0, c'est que c'est un multiple de 3 ou de 5.
    if i % 5 == 0 or i % 3 == 0:
        n += i

print(n)