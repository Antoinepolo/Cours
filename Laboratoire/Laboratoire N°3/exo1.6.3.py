class MyException(Exception):
    def __init__(self, caught_exc):
        super().__init__(str(caught_exc))
        self.caught_exc = caught_exc


try:
    try:
        x = 1 / 0
    except ZeroDivisionError as e:
        raise MyException(e)
except MyException as e:
    print("Mon exception : ", e)
    print("Exception d'origine", e.caught_exc)