class MyObject:
    class_var = 1
    l = [4]


print(MyObject.class_var)   # Affiche 1
o1 = MyObject()
o2 = MyObject()

o1.class_var = 2

print(o1.class_var)
print(o2.class_var)         # On affiche encore 1 car on créer une copie

o1.l[0] = 7
print(o1.l[0])
print(o2.l[0])