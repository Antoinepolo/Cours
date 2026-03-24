# _ protegée
# __ privée

class MyObject:
    def __init__(self):
        self._protected_var = 1
        self.__private_var = 2

    def get_value_protected(self):
        return self._protected_var
    
    def get_value_private(self):
        return self.__private_var


o = MyObject()
print(o._protected_var)
print(o.get_value_private())