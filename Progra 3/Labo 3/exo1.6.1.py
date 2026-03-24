class MyException(Exception):
    pass

class MySecondException(MyException):
    pass

class MyThirdException(MySecondException):
    pass

raise MyThirdException