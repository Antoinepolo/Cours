import threading
import time

# deadlock : situation ou tous les threads se bloquent mutuellement

def f1(lock1, lock2):
    lock1.acquire()
    time.sleep(1)
    lock2.acquire()
    print("F1")
    lock1.release()
    lock2.release()

def f2(lock1, lock2):
    lock1.acquire()
    time.sleep(1)
    lock2.acquire()
    print("F2")
    lock1.release()
    lock2.release()

lock1 = threading.Lock()
lock2 = threading.Lock()

t1 = threading.Thread(target=f1, args=(lock1, lock2))
t2 = threading.Thread(target=f2, args=(lock1, lock2))

t1.start()
t2.start()