import threading

# On va créer une zone mutuellement exclusive (mutex)

class SharedObject:
    def __init__(self):
        self.value = 0

def increment_by_n(shared, n, lock):
    for i in range(n):
        # Ici : un seul thread à la fois!!! sinon => race condition
        lock.acquire() # Si le lock est disponible, le thread le prend, sinon il attend
        shared.value = plus_one(shared.value)
        lock.release() # On relâche le lock pour un autre thread

def plus_one(value):
    return value + 1

# Problème de cocurrence
shared = SharedObject()
lock = threading.Lock() # Un objet qui permet de synchroniser les threads

t1 = threading.Thread(target=increment_by_n, args=(shared, 1000000, lock))
t2 = threading.Thread(target=increment_by_n, args=(shared, 1000000, lock))

t1.start()
t2.start()

t1.join()
t2.join()

print(shared.value)