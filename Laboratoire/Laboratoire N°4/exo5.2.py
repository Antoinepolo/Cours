# Client
from socket import socket, AF_INET, SOCK_STREAM
from sys import argv

# On créer le socket et on le garde pour tout les envoies
with socket(AF_INET, SOCK_STREAM) as socket:
    socket.connect((argv[1], int(argv[2])))
    while True:
        choice = input("Envoyer (e), quitter (q) : ")
        if choice == "e":
            file_name = input("Entrez le nom du fichier : ")
            try:
                # On envoie d'abbord le nom du fichier
                socket.send(file_name.encode())
                # On envoie ensuite les données
                with open(file_name) as file:
                    data = file.read()
                    socket.send(data.encode())

                # On affiche que l'opération c'est bien ou pas bien passé
                data = socket.recv(1024)
                print("Serveur :", data.decode())
            except Exception as e:
                print("Erreur : ", e)

        if choice == "q":
            break
