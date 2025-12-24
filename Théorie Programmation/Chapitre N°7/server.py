from socket import *
from threading import *

class MultiThreadServer:
    def __init__(self):
        self.server_socket = socket(AF_INET, SOCK_STREAM)
        self.server_socket.bind(('localhost', 5000))
        self.server_socket.listen()


    def listen_loop(self):
        while True:
            client_socket, client_address = self.server_socket.accept()
            Thread(target=self.handle_client, args=[client_socket]).start()

    # méthode pour gérer la communication avec un client
    # c'est le travail effectuer par le serveur
    def handle_client(self, client_socket):
        data = client_socket.recv(1024)
        while data:
            print(data.decode())
            data = client_socket.recv(1024)
        client_socket.close()

server = MultiThreadServer()
server.listen_loop()