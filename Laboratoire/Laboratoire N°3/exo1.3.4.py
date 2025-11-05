import traceback

def fonction1():
    error = BaseException("Mon exception")
    raise error

def fonction2():
    try:
        fonction1()
    except BaseException:
        print("Erreur interceptée dans la fonction 2")
        raise

def fonction3():
    try:
        fonction2()
    except BaseException:
        print("Erreur interceptée dans la fonction 3")
        raise

try:
    fonction3()
except BaseException:
    print("Exception interceptée dans le bloc pincipal")
    traceback.print_exc()