def fonction1():
    error = BaseException("Mon exception")
    raise error

def fonction2():
    fonction1()

fonction2()