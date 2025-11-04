import traceback

def fonction1():
    error = BaseException("Mon exception")
    raise error

def fonction2():
    fonction1()

def fonction3():
    fonction2()

try:
    fonction3()
except BaseException as error:
    traceback.print_exc()