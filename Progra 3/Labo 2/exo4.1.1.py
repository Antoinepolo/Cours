from abc import ABC

# Définition des classes
class Vehicule(ABC):
    def __init__(self, brand, fuel):
        self.brand = brand
        self.fuel = fuel

class RoadVehicule(Vehicule, ABC):
    def __init__(self, brand, fuel, km):
        super().__init__(brand, fuel)
        self.km = km

class Car(RoadVehicule):
    def __init__(self, brand, fuel, km):
        super().__init__(brand, fuel, km)

class Truck:
    def __init__(self, brand, fuel, km, weight):
        super().__init__(brand, fuel, km)
        self.weight = weight

class Boat(Car):
    def __init__(self, brand, fuel, tonnage):
        self.fuel = fuel
        self.tonnage = tonnage

class Plane(Vehicule):
    def __init__(self, brand, fuel, range):
        super().__init__(brand, fuel)
        self.range = range

# Fonction pour afficher le menu
def affichage_menu():
    print("\033[1;34m=== OPTIONS ===\033[0m")
    print("C => Car")
    print("T => Truck")
    print("B => Boat")
    print("P => Plane")
    print("A => Afficher")
    print("Q - Quitter\n")

# Fonction pour créer une voiture
def new_car():
    brand = input("Entrez la marque : ")
    fuel = int(input("Entrez la jauge du réservoir : "))
    km = int(input("Entrez le kilométrage : "))
    return Car(brand, fuel, km)

# Fonction pour créer un camion
def new_truck():
    brand = input("Entrez la marque : ")
    fuel = int(input("Entrez la jauge du réservoir : "))
    km = int(input("Kilométrage : "))
    weight = int(input("Poids : "))
    return Car(brand, fuel, km)

# Fonction pour créer un bateau
def new_boat():
    brand = input("Entrez la marque : ")
    fuel = int(input("Entrez la jauge du réservoir : "))
    tonnage = int("Entrez le poids (en tonne) : ")
    return Boat(brand, fuel, tonnage)

# Fonction pour créer un avion
def new_plane():
    brand = input("Entrez la marque : ")
    fuel = int(input("Entrez la jauge du réservoir : "))
    range = int("Entrez la distance maximale")
    return Plane(brand, fuel, range)

# Fonction pour afficher les informations
def afficher(vehicules):
    for line in vehicules:
        print(line)
    print("\n")

vehicules = []

# Boucles principales
while 1:
    affichage_menu()
    choix = input("> Choisir une option : ")

    if choix == 'C':
        n = new_car()
        vehicules.append(n)
        print("\033[1;32mEnregistrer !\033[0m\n")
    elif choix == 'T':
        n = new_truck()
        vehicules.append(n)
        print("\033[1;32mEnregistrer !\033[0m\n")
    elif choix == 'B':
        n = new_boat()
        vehicules.append(n)
        print("\033[1;32mEnregistrer !\033[0m\n")
    elif choix == 'P':
        n = new_plane()
        vehicules.append(n)
        print("\033[1;32mEnregistrer !\033[0m\n")
    elif choix == 'A':
        afficher(vehicules)
    elif choix == 'Q':
        exit()
    else:
        print("\033[1;31mErreur : Choix invalide\033[0m\n")