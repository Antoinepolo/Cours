import threading

class SharedObject:
    def __init__(self):
        self.value = 0


def increment_by_n(shared, n):
    for i in range(n):
        shared.value = plus_one(shared.value)

def plus_one(value):
    return value + 1

# Problème de cocurrence
shared = SharedObject()

t1 = threading.Thread(target=increment_by_n, args=(shared, 1000000))
t2 = threading.Thread(target=increment_by_n, args=(shared, 1000000))

t1.start()
t2.start()

t1.join()
t2.join()

print(shared.value)