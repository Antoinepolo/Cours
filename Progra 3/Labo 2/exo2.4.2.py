class A:
    def who_am_i(self):
        print("A")

class B:
    def who_am_i(self):
        print("B")
class C(B, A):
    def who_am_i(self):
        print("C")