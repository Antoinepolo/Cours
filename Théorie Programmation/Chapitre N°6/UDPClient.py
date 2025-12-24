from socket import socket, AF_INET, SOCK_DGRAM

# ======================
#      Client UDP
# ======================

class UDPClient:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.client_socket = socket(AF_INET, SOCK_DGRAM)

    # Pas besoin de start, on envoie direct

    def run(self):
        with self.client_socket:
            s = "Hello!"
            data = s.encode()
            self.client_socket.sendto(data, (self.host, self.port))

client = UDPClient("localhost", 6000)
client.run()