# --------------------------------
#              LISTS
# --------------------------------

# Tri
l = [3, 1, 2]
l.sort()
print(l)

l2 = [1, 4, 6, 8]

# Boucle
for i in l2:
    print(i)

# Append et insert
l2.append(5)
l2.insert(0, 3)
print(l2)

# Additionner deuxx lists
l2.extend([9, 4, 2])
print(l2)

# Accéder à un élement
print(l2[2])

# Suppirmer un élement
del(l2[1])
print(l2)

# Supprimer et récuperer un élément
retirer = l2.pop(0)
print(retirer)
print(l2)

# Inverser une list
l2.reverse()
print(l2)

# Retirer une valeur
l2.remove(9)
print(l2)

# Vider une list
l2.clear()
print(l2)

# Concaténation de list
l1 = [1, 2, 3]
l2 = [4, 5, 6]
print(l1 + l2)

# Multiplier une list
print(l1 * 4)

# Une liste est non homogène
l = [1, 2, 3, "Hello", [1, 3]]

# Opérateur in
l = [4, 6, 8, 9]
a = 3
print(a in l)
print(a not in l)

# Longueur de la liste
print(len(l))

# Min et max
print(max(l))
print(min(l))

# Slicing
l = [1, 2, 3, 4, 5, 6, 7, 8, 9]
print(l[1:5])
print(l[:4])
print(l[1:])

# Indice négatif
l = [7, 6, 2, 8]
print(l[-1])

# --------------------------------
#             TUPLES
# --------------------------------

# Tuple
t = (5, 6, 7)
print(t)
print(t[1])

# --------------------------------
#             RANGES
# --------------------------------

# Création
r = range(5) # 5 exclus
print(r)
print(r[2])

# Boucle
for i in r:
    print(i)

# --------------------------------
#             STRINGS
# --------------------------------

# Simple quote
s1 = 'ABC'

# Double quote
s2 = "ABC"

# Tripple quote
s3 = '''ABC'''

print(s1)
print(s2)
print(s3)

# Accéder à une valeur
print(s1[0])

print(s1.capitalize())
print(s1)

print(s2.startswith(('A'))) # On peut mettre plusieurs caractères
print(s2.endswith('B'))

# --------------------------------
#              BYTES
# --------------------------------

# Création
b = b'\x41\x42\x43\x44' # ABCD
print(b)
print(type(b))

# Encoder
s = 'ABC'
b = s.encode()
print(b)

sbis = b.decode()
print(sbis)