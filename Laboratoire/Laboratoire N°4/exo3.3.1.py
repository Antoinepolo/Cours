from sys import argv

file = open(argv[1], "rb")
estASCII = True

while True:
    octet = file.read(1)
    if not octet:
        break
    if octet[0] >= 128:
        estASCII = False
        break

file.close()

if estASCII:
    print("ASCII")
else:
    print("Pas ASCII")
