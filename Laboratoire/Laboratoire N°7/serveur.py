from socket import *
from threading import *
import sys

lock = Lock()

class MultiThreadServer:
    def __init__(self):
        self.server_socket = socket(AF_INET, SOCK_STREAM)
        self.server_socket.bind((sys.argv[1], int(sys.argv[2])))
        self.server_socket.listen()


    def listen_loop(self):
        while True:
            client_socket, client_address = self.server_socket.accept()
            Thread(target=self.handle_client, args=[client_socket]).start()

    # méthode pour gérer la communication avec un client
    # c'est le travail effectuer par le serveur
    def handle_client(self, client_socket):
        data = client_socket.recv(1024)
        data = data.decode()
        content = data.split("#")
        with lock:
            fic_name = content[0] + ".log"
            with open(fic_name, "a") as fic:
                fic.write(content[1] + "\n")

        client_socket.close()

server = MultiThreadServer()
server.listen_loop()
