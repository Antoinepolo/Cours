class MyObject:
    def say_hello(self):
        print("Hello!")
        self.say_hello()    # Génrère une erreur car on fait trop de récusivité

    def add(self, a, b):
        return a + b
    
o1 = MyObject()
#o1.say_hello()
print(o1.add(1, 2))