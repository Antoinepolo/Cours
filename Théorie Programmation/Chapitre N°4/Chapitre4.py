# --------------------------------
#            OBJECTS
# --------------------------------

class Dog:
    name = "Médor"
    age = 5

dog = Dog()
print(dog.name)
dog2 = Dog()
print(dog2.name)
dog2.name = "Milou"
print(dog2.name)
print(dog.name)
# => Chaque objet est indépandant, si on en modif un, l'autre un ne sera pas affecter

print(dog.name is dog2.name) # Si on ne le change pas, il est partager entre deux objets

class TestShare:
    l = [] # Variable de classe partagée par toutes les instances, si on la modifie
           # dans un objet, tout les autres veront leur valeurs modifier.

ts1 = TestShare()
ts2 = TestShare()

ts1.l.append(1)
print(ts2.l) # Affiche 1 alors qu'on l'a ajouter à ts1

# La solution pour remédioer à ce problème est de passer par un consturcteur

# --------------------------------
#          CONSTRUCTEUR
# --------------------------------

class Dog:
    def __init__(self, name, age): # Si on veut, on peut mettre des valeurs par défaut ici.
        self.name = name # Variable d'instances propre à chaque objet.
        self.age = age
        self.l = []
        # Il va utiliser cette fonction quand il créer un objet.
        # Self = moi même, l'objet lui même on déclare un attribut propre à l'objet.

    # Méthode de classe, doit toujours prendre self (aussi appelée méthode d'instance).
    def sayWouf(self):
         print("Wouf")

    # Méthode d'instance (ici on va chercher le name de l'objet lui même)
    def printName(self):
        print(self.name)

    # Modifier une variable
    def changeAge(self, age):
        self.age = age

# Création des objets (instances)
d = Dog("Médor", 5)
d2 = Dog("Milou", 7)
print(d.l is d2.l) # On a créer deux listes distinctes, ce sont des variable d'instance.
                   # Au contraire, une variable de classe est partagée entre les instances.

# Tests des méthodes
d.sayWouf()
d.printName() # Quand on appelle, on ne passe pas de paramètre, car ici self est d

# Changer l'âge
print(d2.age)
d2.changeAge(10)
print(d2.age)

# Fonction dir
print(dir(d2)) # Listes des méthodes et des variables
print(d2.__class__) # Affiche le nom de la classe, comme type()
print(d2.__dict__) # Transforme l'état de l'objet en dictionnaire

# --------------------------------
#            HERITAGE
# --------------------------------

# Héritage : difinition des caractéristiques communes dans le parents, et ensuite
# on a des classes enfants qui reprennent les caractéristiques du parent et qui en
# rajoute des nouvelles.

# Classe parent
class Animal:
    def __init__(self, nom, age):
        self.nom = nom
        self.age = age

# Classe enfant
class Dog(Animal):
    def __init__(self, nom, age):
        super().__init__(nom, age)

    def makeSound(self):
        print(("wouf"))

# On créer les objets
animal = Animal(nom = "Animal1", age = 20)
print(animal.nom)

dog = Dog(nom = "dog1", age = 10)
print(dog.nom)

# Classe enfant de dog, petit enfant
class Doberman(Dog):
    def __init__(self, nom, age, teeth):
        # Super représente la classe juste au dessus (le parent), il ne prend pas self
        super().__init__(nom, age)
        self.teeth = teeth

    def makeSound(self):
        print(("GRRRR"))

    # Appel à la méthode du parent
    def makeSoundParent(self):
        super().makeSound()

# Tests
dob = Doberman(nom = 'Dobber', age = 20, teeth = 10)
print(dob.nom)
print(dob.teeth)
dob.makeSound()
dob.makeSoundParent()

# Classe avec plusieurs parentss
class Hamster(Animal):
    def makeSound(self):
        print("Cui cui")

class Pokémon():
    def makeSound(self):
        print("Pokémon")

# On peut mettre plusieurs parent
class Pikachu(Pokémon, Hamster):
    pass

pika = Pikachu("pika", 5) # Il va d'abbord chercher dans le premier et ensuite le second
pika.makeSound()

# --------------------------------
#            DIAMOND
# --------------------------------

class A:
    def methodB(self):
        print("Classe A")

    def methodC(self):
        print("Classe A")

class B(A):
    def methodB(self):
        print("Classe B")

class C(A):
    def methodC(self):
        print("Classe C")

class D(B, C):
    pass

d = D()
d.methodB()
print(D.mro()) # Dans quelle ordre il va cherhcer les méthodes

# MRO = Mééthod résolution order

# --------------------------------
#          ABSTRACTION
# --------------------------------

# Abstraction : Déclaration de quelques choses sans fournir concraitement comment
# ce quelques chose fonctionne

from abc import ABC, abstractmethod # Abstract Base Class pour les méthodes abstraites

# On ne veut pas utiliser Animal, mais juste ses enfants
class Animal(ABC):

    @abstractmethod # Il n'y a pas d'implémentation pour cette méthode, ça doit être implémenter dans les enfants
    def makeSound(self):
        pass

class Dog(Animal):
    # On est forcer de donner des implémentation des méthodes abstraites du parent
    def makeSound(self):
        print("Wouf")

class Cat(Animal):
    def makeSound(self):
        print("Miaou")

d = Dog()
d.makeSound()

c = Cat()
c.makeSound()

# --------------------------------
#          ENCAPSULATION
# --------------------------------

# L'encapsulation est le fait de cahcer le fonctionnement interne de l'objet.
# On va seulement montrer des moyens externes de manipuler l'objet.

class HiddenObject:
    def __init__(self):
        self.__value = 123
        # __ = élément cacher

    def get_value(self):
        return self.__value

    def set_value(self, value):
        self.__value = value

h = HiddenObject()
print(h.get_value())