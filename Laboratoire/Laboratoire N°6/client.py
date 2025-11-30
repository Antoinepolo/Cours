import sys
import threading
from socket import socket, AF_INET, SOCK_STREAM

# Usage : python client.py address port pseudo

class TCPClient:
    def __init__(self, host, port, pseudo):
        self.host = host
        self.port = port
        self.pseudo = pseudo
        self.client_socket = socket(AF_INET, SOCK_STREAM)

    def start(self):
        # On se connecte au serveur
        self.client_socket.connect((self.host, self.port))
        print(f"Connecté au serveur {self.host}:{self.port}")

        # Thread pour écouter les messages
        threading.Thread(target=self.receive_messages, daemon=True).start()

        # Boucle pour envoyer les messages
        while True:
            msg = input("> ")
            full_msg = f"{self.pseudo} : {msg}"
            self.client_socket.send(full_msg.encode())

    def receive_messages(self):
        # Fonction qui tourne en parallèle pour reçevoir les messages
        while True:
            try:
                data = self.client_socket.recv(1024)
                if not data:
                    break
                print(data.decode())
            except:
                break

client = TCPClient(sys.argv[1], int(sys.argv[2]), sys.argv[3])
client.start()