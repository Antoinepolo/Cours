# --------------------------------
#          DICTIONNAIRES
# --------------------------------

# Bases
d = {}

d["k1"] = 1
d["k2"] = 2
d[1] = 16
d["k1"] = 50

print(d)
print(d["k1"])
print(d[1])

d2 = {"k1" : 13, "k2" : 42}
print(d2)

# Méthodes
print(d.keys())
print(d.values())

print("k1" in d.keys())
print(2 in d.values())

print(d.items())

for i in d.items():
    print(i)

for k, v in d.items(): # Unpacking
    print(k, v)

# --------------------------------
#          FLOW CONTROL
# --------------------------------

t = True
f = False

if t:
    print("true")
else:
    print("false")

a = 1
b = 2
c = 3
n = 2

if n == 1:
    print(1)
elif n == 2:
    print(2)
else:
    print(3)

# --------------------------------
#             BOUCLE
# --------------------------------

i = 0
while i < 5:
    print(i)
    i += 1

for i in range(5):
    print(i)

# --------------------------------
#            FONCTIONS
# --------------------------------

# Fonction basique
def my_function():
    print("Hello")

# Fonction avec un paramètre
def print_something(s):
    print(s)

my_function()
print_something("coucou !")
print_something(1+3)

# Fonction avec plusieurs paramètres
def add_and_print(a, b):
    print(a + b)

add_and_print(1, 7)

# Fonction avec paramètre par défaut
def func_with_default(s = "Default"):
    print(s)

func_with_default("Hello")
func_with_default()

# Fonction avec paramètres nommés
def div_with_name(a, b):
    print(a / b)

div_with_name(b = 2, a = 6)

print(1, 2, 3, sep="-", end="X\n") # On peut retirer le retour à la ligne

# Retour
def add(a, b):
    return a + b

res = add(5, 6)
print(res)

print(add(1, 2))

def no_return():
    pass

print(no_return()) # Une fonction qui ne retourne rien retourne none

def add5(a):
    a = a + 5
    return a

x = 1
x = add5(x)
print(x)

def addElement(l, n):
    l.append(n)

l = [1, 2, 3]
addElement(l, 6)
print(l)

# --------------------------------
#            OBJECTS
# --------------------------------

class Cat:
    name = "Gertrude"
    age = 5

cat1 = Cat()
print(cat1.name)
cat1.age = 10
print(cat1.age)

class Dog:
    def __init__(self, nom, age):
        self.nom = nom
        self.age = age

# Instancier un objet (on en créer un a partir de la classe), l'objet est une instance de la classe
dog1 = Dog("Jean", 2)
print(dog1.nom)
print(type(dog1))