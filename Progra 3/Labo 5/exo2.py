import sys
import threading
import os

# Commande : python exo2.py <s> <folder_path> <max_threads>
# Ici, on récup nos variables
s = sys.argv[1]
folder_path = sys.argv[2]
max_threads = int(sys.argv[3])

thread_actif = [0]

# Foncton qui reçoit un fichier (chemin vers le txt) et qui affiche ce chemin si la chaine a été trouvé
# On renvoie le chemin du fichier si ça a été trouvé, sinon on renvoie None
def search_file(file_path, s):
    est_trouve = False

    # On ouvre le fichier 
    with open(file_path, "r") as file:
        # On parcour toutes les lignes, si on trouve un correspondance on quitte la boucle et on la return
        for line in file:
            if s in line:
                est_trouve = True
                break

    if est_trouve:
        return file_path
    else:
        return None

def job(file_path, s, condition):
    # Si on a un résultat, on l'affiche puis on décrémente le nombre de thread actif
    res = search_file(file_path, s)
    if res != None:
        print(res)

    with condition:
        thread_actif[0] -= 1
        condition.notify()



def start_threads(folder_path, s, max_threads, condition):
    for entry in os.scandir(folder_path):
        if entry.is_file():
            file_path = entry.path

            # On parcour tout les path possible et au lieu de faire une liste avec les threads comme avant,
            # on bloque leur création si ça dépasse (ou égal) au nombre de thread maximal
            with condition:
                while thread_actif[0] >= max_threads:
                    condition.wait()

                # On lance un nouveau thread
                thread = threading.Thread(target=job, args=(file_path, s, condition))
                thread.start()
                thread_actif[0] += 1

# Main
#l = []
#
#for entry in os.scandir(folder_path):
#    if entry.is_file():
#        l.append(entry.name)

#print(l)

# On créer la condition et on fait appel a la fonction
condition = threading.Condition()
start_threads(folder_path, s, max_threads, condition)