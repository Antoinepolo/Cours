# Fonctions
def mettreEnMaj(char):
    # On convertit en code ASCII, puis on retire 32, recast puis return.
    code = ord(char)
    code -= 32
    char = chr(code)
    return char

# Tests
print(mettreEnMaj('a'))