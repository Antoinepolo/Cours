class Animal:
    def __init__(self, weight, species):
        self.weight = weight
        self.species = species

class Pet:
    def __init__(self, name):
        self.name = name

class Cat(Animal, Pet):
    def __init__(self, weight, species, name):
        Animal.__init__(self, weight, name)
        Pet.__init__(self, name)