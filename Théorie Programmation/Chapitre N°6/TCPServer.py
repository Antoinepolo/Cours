from socket import socket, AF_INET, SOCK_STREAM

# ======================
#      Serveur TCP
# ======================

class TCPServer:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.server_socket = socket(AF_INET, SOCK_STREAM)

    def start(self ):
        # On met une double paranthèse car bind attend un tuple
        self.server_socket.bind((self.host, self.port)) # On associe le serveur avec un coupe adresse port
        self.server_socket.listen() # on écoute les demandes de connexion (SYN SYN ACK ACK)
        # On l'appelle le 4 way handachake (les trois flèches)

    # Attention fonction bloquante comme input temps qu'il n'y a pas de connexion
    def get_connection(self):
        # Sur le serveur on aura toujours deux socket, un qui écoute les demandes de connexion et un pour les connexions
        # accept : réception d'une demande de connexion et création d'un nouveau socket pour la communication
        client_socket, client_address = self.server_socket.accept()
        return client_socket, client_address

    def run(self):
        self.start()
        client_socket, client_address = self.get_connection()
        with client_socket:
            data = client_socket.recv(1024) # 1024 c'est la taille du buffer en byte (on peut reçevoir 1024 bytes au maximum)
            # La fonction renvoie une variable de type byte
            s = data.decode() # On transforme les bytes en texte (type str)

            print(f"Reçu de {client_address} : {s}")
            echo = s.encode() # On ré-encode
            client_socket.send(echo) # on le renvoie au client

server = TCPServer("localhost", 5000)
server.run()