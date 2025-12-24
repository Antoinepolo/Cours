from socket import socket, AF_INET, SOCK_STREAM

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
            data = self.client_socket.recv(1024)
            s = data.decode()
            print(f"Reçu du serveur en retour : {s}")

client = TCPClient("localhost", 5000)
client.run()