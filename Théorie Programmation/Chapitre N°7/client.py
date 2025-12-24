from socket import socket, AF_INET, SOCK_STREAM
import threading

class TCPClient:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.client_socket = socket(AF_INET, SOCK_STREAM)

    def start(self):
        self.client_socket.connect((self.host, self.port)) # Etablissement de connexion

    def run(self):
        self.start()
        with self.client_socket:
            s = "Hello!"
            data = s.encode() # UTF-8 par défaut
            self.client_socket.send(data)
            s = "Coucou"
            data = s.encode() # UTF-8 par défaut
            self.client_socket.send(data)

"""
def new_client(host, port):
    client = TCPClient(host, port)
    client.run()

for i in range(50):
    threading.Thread(target=new_client)
"""

client = TCPClient("localhost", 5000)
client.run()