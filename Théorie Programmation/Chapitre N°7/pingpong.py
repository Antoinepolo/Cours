import time
import threading

# impossible de synchroniser avec des simples lock!!
# on ne peut pas prédire quel sera le thread suivant...

def ping(lock):
    while True:
        lock.acquire()
        print("ping")
        time.sleep(1)
        lock.release()

def pong(lock):
    time.sleep(1) # delai pour pas démarrer en même temps
    while True:
        lock.acquire()
        print("pong")
        time.sleep(1)
        lock.release()

lock = threading.Lock()

t1 = threading.Thread(target=ping, args=(lock,))
t2 = threading.Thread(target=pong, args=(lock,))

t1.start()
t2.start()