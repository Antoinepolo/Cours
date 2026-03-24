class Animal:
    def __init__(self, weight, species):
        self.weight = weight
        self.species = species

    def print_info(self):
        print(f"{self.weight}, {self.species}")

class Cat(Animal):
    def __init__(self, weight, spicies, fut_color):
        super().__init__(weight, spicies)
        self.fut_color = fut_color

class Bird(Animal):
    pass

class Pigeon(Bird):
    def __init__(self, weight, spicies, wingspan):
        super().__init__(weight, spicies)
        self.wingspan = wingspan

c = Cat(50, "Tamed", "Jaune")
c.print_info()

p = Pigeon(50, "Gauthier", "Chepa")
p.print_info()

print(issubclass(Pigeon, Bird))    # True
print(issubclass(Pigeon, Animal))  # True
print(isinstance(p, Pigeon))       # True
print(isinstance(p, Bird))         # True
print(isinstance(p, Animal))       # True