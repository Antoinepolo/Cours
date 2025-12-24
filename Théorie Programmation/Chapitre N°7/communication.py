# communication entre les threads pour synchroniser leurs actions
# utilisation de l'objet condition

import time
import threading

# impossible de synchroniser avec des simples lock!!
# on ne peut pas prédire quel sera le thread suivant...

def ping(cond):
    while True:
        cond.acquire()
        print("ping")
        time.sleep(1)
        cond.notify()
        cond.wait()

def pong(cond):
    time.sleep(1) # delai pour pas démarrer en même temps
    while True:
        cond.acquire()
        print("pong")
        time.sleep(1)
        cond.notify()
        cond.wait()

cond = threading.Condition()

t1 = threading.Thread(target=ping, args=(cond,))
t2 = threading.Thread(target=pong, args=(cond,))

t1.start()
t2.start()