class Animal:
    def __init__(self, weight, species):
        self.weight = weight
        self.species = species

    def print_onfo(self):
        print(f"{self.weight}, {self.species}")

a1 = Animal(18, "Chien")
a2 = Animal(12, "Pigeon")

a2.print_onfo()
print(a1.__class__)