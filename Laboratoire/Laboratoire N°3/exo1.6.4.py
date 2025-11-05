import traceback

class MyException(Exception):
    def __init__(self, caught_exc):
        super().__init__(caught_exc)
        self.caught_exc = caught_exc
try:
    try:
        x = 5 + "D"
    except TypeError as e:
        raise MyException(e)
except MyException as e:
    print(e)
    traceback.print_exc()