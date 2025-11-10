# udp=client.py

from socket import (socket, AF_INET, SOCK_DGRAM)

# SOCK_DGRAM : Socket Datagram (UDP)
with (socket(AF_INET, SOCK_DGRAM) as socket):
    server_addr = ("localhost", 5000)
    nb = 1
    while nb != 0:
        nb = int(input("Entrez un nombre (0 pour terminer) : "))
        data = str(nb).encode()
        socket.sendto(data, server_addr)

    data, addr = socket.recvfrom (1024)
    print("Received from server :", data.decode())