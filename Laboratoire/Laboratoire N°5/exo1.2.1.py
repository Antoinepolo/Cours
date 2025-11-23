import threading

def pop_or_push(lock, l, n):
    for i in range(n):
        with lock:
            if len(l) == 0:
                l.append("X")
            else:
                l.pop()

l = []
lock = threading.Lock()

for i in range(100):
    threading.Thread(target=pop_or_push, args=(lock, l, 100000)).start()
