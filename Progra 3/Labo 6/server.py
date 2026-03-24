import sys
import threading
from socket import socket, AF_INET, SOCK_STREAM

# python server.py 5000

# ======================
#      Serveur TCP
# ======================

class TCPServer:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        # On créer le socket
        self.server_socket = socket(AF_INET, SOCK_STREAM)
        # On stocke les clients connectés dans une liste
        self.clients = []

    def start(self ):
        # On met une double paranthèse car bind attend un tuple
        self.server_socket.bind((self.host, self.port)) # On associe le serveur avec un coupe adresse port
        self.server_socket.listen() # on écoute les demandes de connexion (SYN SYN ACK ACK)
        # On l'appelle le 4 way handachake (les trois flèches)


    def broadcast(self, message, sender_socket):
        # On envoie le message a tout les client sauf l'envoyeur
        for client in self.clients:
            if client != sender_socket:
                client.send(message)

    def handle_client(self, client_socket, client_address):
        print(f"Connexion de {client_address}")
        self.clients.append(client_socket)
        try:
            while True:
                # On réceptionne les données
                data = client_socket.recv(1024)
                # On sort si le client ferme la connexion
                if not data:
                    break

                # On formate le message et on l'affiche (côte serveur)
                msg = data.decode()
                print(msg)

                # On envoie le message en faisant appel à la fonction de broadcast
                self.broadcast(msg.encode(), client_socket)
        finally:
            # Quand le client se déconnecte, on le retire de la liste et on ferme le socket
            print(f"Déconnexion de {client_address}")
            # On elève le socket qui a été fermer de la liste
            self.clients.remove(client_socket)
            client_socket.close()


    def run(self):
        # On bind et on démarre l'écoute
        self.start()
        while True:
            # On attend qu'un client se connecte, et quand on en a un, on lui créer un thread
            client_socket, client_address = self.server_socket.accept()
            # On créer le thread qui va gérer la réception et l'envoie des données
            thread = threading.Thread(target=self.handle_client, args=(client_socket, client_address))
            thread.start()

# On créer un objet de type TCPServer
server = TCPServer("localhost", int(sys.argv[1]))
# Boucle principale
while True:
    server.run()