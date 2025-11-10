from sys import argv

total = 0
# Pas oublier de slicer, sinon argv[]
for arg in argv[1:]:
    total += int(arg)

print(total)