import threading
import time

def count_to_n(n):
    for i in range(n):
        print(i)
        time.sleep(1)

#count_to_n(5)

# Args = toujours un tuple
t = threading.Thread(target=count_to_n, args=(5,))
t.start()

t.join() # attendre que le thread t se termine avant de poursuivre

print("main thread done")