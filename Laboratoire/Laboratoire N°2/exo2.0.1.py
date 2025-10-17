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

class Pigeon(Animal):
    def __init__(self, weight, spicies, wingspan):
        super().__init__(weight, spicies)
        self.wingspan = wingspan

c = Cat(50, "Tamed", "Jaune")
c.print_info()

p = Cat(50, "Gauthier", "Chepa")
p.print_info()