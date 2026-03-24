# Fonction
# *args = tuple
def volBoite(*args):

    # Si la longueur est 0
    if len(args) == 0:
        return -1

    # Si la longueur est de 1
    elif len(args) == 1:
        x1 = args[0]
        return x1 ** 3
    
    # Si on a deux arguments
    elif len(args) == 2:
        x1, x2 = args
        return x1 ** 2 * x2
    
    # Si on a trois arguments
    elif len(args) == 3:
        x1, x2, x3 = args
        return x1 * x2 * x3
    
    # Si on a plus de trois arguments
    else:
        return -1

# Tests
print(volBoite())
print(volBoite(5.2))
print(volBoite(5.2, 3))
print(volBoite(5.2, 3, 7.4))