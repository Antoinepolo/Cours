# Parties de programmes qui peuvent s'exécuter simultanément
# But : optimiser l'usage des ressources (CPU) en faisant plusieurs chose en même temps

import threading
import time

# Tout programme python qui s'execute est lui même un thread

# Main Thread
t = threading.current_thread()
print(type(t))
print(t.name) # MainThread (le thread principal)
print(t.is_alive()) # Est-il encore en vie

def thread_job():
    print("Thread is doing a job")
    time.sleep(5)

t = threading.Thread(target=thread_job) # Target = code a executer (on ne met pas de () car on ne veut pas de retour)
print(type(t))
print(t.name)
print(t.is_alive()) # False, il est plus en cours d'exécution
t.start() # On démarre le thread (au dessus on l'a juste définit)
print(t.is_alive()) # Toujours false car il a finit sa tache (true après avoir mit le sleep)