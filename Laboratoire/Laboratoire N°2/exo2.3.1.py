class Bird():
    def fly(self):
        print("pouik pouik")

class Plane:
    def fly(self):
        print("vmmm")

def start_fly(obj):
    obj.fly()

start_fly(Bird())
start_fly(Plane())