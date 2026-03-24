from abc import ABC, abstractmethod

class Animal(ABC):
    def __init__(self, weight, species):
        self.weight = weight
        self.species = species

    @abstractmethod
    def print_info(self):
        print(f"{self.weight}, {self.species}")

class Cat(Animal):
    def __init__(self, weight, spicies, fut_color):
        super().__init__(weight, spicies)
        self.fut_color = fut_color

    def print_info(self):
        print(f"{self.weight}, {self.species}, {self.fut_color}")
        super().print_info()

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