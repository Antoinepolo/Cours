class MyObject:
    pass

m1 = MyObject   # Référence
print(type(m1))

m2 = MyObject() # Appel le constructeur
print(type(m2))

print(m1 == m2) # False
print(m1 is m2) # False