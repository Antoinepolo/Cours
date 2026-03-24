# server.py
from socket import socket, AF_INET, SOCK_STREAM

# on crée un socket d’écoute
# AF_INET : Adress Family Internet (IP)

# SOCK_STREAM : Socket Stream (TCP)
with socket(AF_INET, SOCK_STREAM) as server_socket :
    server_addr = ("localhost", 5000)
    server_socket.bind(server_addr) # on le lie à un tuple ip/port
    server_socket.listen() # on le met en mode écoute

    # on attend une connexion => bloquant!
    # quand une connexion est reçue, un socket est créé pour communiquer et
    # l’addresse du client est récupérée
    client_socket, client_address = server_socket.accept()

with client_socket: # on veut fermer le socket de communication
    data = client_socket.recv(1024) # on reçoit des données (max 1024 bytes)
    while data: # tant qu’on a reçu des données
        data = data[::-1]
        client_socket.send(data) # on les renvoie
        data = client_socket.recv(1024) # et on reçoit les suivantes