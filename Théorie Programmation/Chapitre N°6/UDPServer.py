from socket import socket, AF_INET, SOCK_DGRAM

# ======================
#      Serveur UDP
# ======================

class UDPServer:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.server_socket = socket(AF_INET, SOCK_DGRAM) # Création d'un socket UDP/IP


    def start(self):
        self.server_socket.bind((self.host, self.port))
        # Pas besoin d'attendre une connexion, c'est UDP donc on envoie comme ça (pas de handshake)

    def run(self):
        self.start()
        with self.server_socket:
            # Ici c'est la reception qui est bloquante, mais ici ce n'est pas l'établissement de la connexion
            data, client_address = self.server_socket.recvfrom(1024)
            s = data.decode()
            print(f"Reçu de {client_address} : {s}")

server = UDPServer("localhost", 6000)
server.run()