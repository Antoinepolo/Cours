class EvenNumberError(Exception):
    pass

def is_pair_number(n):
    if n % 2 == 0:
        raise EvenNumberError
    
try:
    is_pair_number(5)
    print("Test 1 passé")
    is_pair_number(6)
    print("Test 2 passé")
except EvenNumberError:
    print("Erreur : La fonction ne prend que des nombres impairs !")