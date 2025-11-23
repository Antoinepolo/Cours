import threading

# On créer un objet de synchronisation
cond = threading.Condition()

# Liste des threads en attente
threads_waiting = []

# Liste avec un élément qui sert à stocker le mot à afficher (on prend une liste que que ce soit muable et visible par tout les threads)
shared_word = [None]

# Name est le nom du thread
def worker(name):
    global shared_word

    # Boucle infinie (chaque thread reste actif jusqu'à ce qu'on lui demande de s'arrêter)
    while True:
        # Equivalent à cond.acquire puis close
        with cond:
            # On marque le thread en attente (si il ne l'est pas)
            if name not in threads_waiting:
                threads_waiting.append(name)
            # On le met en pause et attend un cond.notify()
            cond.wait()

            # Si ça vaut None, on arrête le thread, sinon on affiche le mot
            if shared_word[0] is None:
                break

            print(f"{name} dit : {shared_word[0]}")
            shared_word[0] = None
            threads_waiting.remove(name)

thread_list = []
for i in range(0, 5):
    # args doit toujours être un tuple (même si on ne passe qu'un seul argument)
    thread = threading.Thread(target=worker, args=(f"Thread-{i+1}",))
    thread.start()
    thread_list.append(thread)

# On demande 5 fois un mot et puis on réveille les threads en question
for i in range(0, 5):
    word = input("Enrez un mot : ")
    if not threads_waiting:
        print("Tous les threads ont terminé")
        break
    with cond:
        shared_word[0] = word
        cond.notify(1)

with cond:
    shared_word[0] = None
    cond.notify_all()

for t in thread_list:
    t.join()

print("Fin du programme")