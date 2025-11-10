from sys import argv

file = open(argv[1], "rb+")
pos = 0

while True:
    octet = file.read(1)
    if not octet:
        break
    octet_int = octet[0] + 3
    octet = bytes([octet_int])
    file.seek(pos)
    file.write(octet)
    pos += 1

file.close()