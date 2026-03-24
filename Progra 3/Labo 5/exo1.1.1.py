import threading

# On créer une liste et on la remplie (sinon on ne peut pas modif une case qui n'existe pas)
l = [0] * 1000

# On créer une conftion qui a ajoute les nombres à la liste en partant d'un indice et départ de fin
def ajouter_nombres(debut, fin):
    for i in range(debut, fin):
        l[i] = i + 1

nb_threads = 10
nb_par_thread = 100
threads = []

# On créer une boucle pour créer et lancer les threads
for thr in range(nb_threads):
    # On calcul le début (pour le thread en question)
    debut = thr * nb_par_thread
    # On prend la fin normale si on est pas sur le dernier thread, sinon en prend 1000
    fin = (thr + 1) * nb_par_thread if thr != nb_threads - 1 else 1000
    # On créer le thread
    thread = threading.Thread(target=ajouter_nombres, args=(debut, fin))
    # On met le thread dans la liste
    threads.append(thread)
    # On le démarre
    thread.start()

# On bloque le programme temps que tout les threads ne sont pas finit
for tread in threads:
    thread.join()

print(l[:10], "...", l[-10:])
print(len(l))
