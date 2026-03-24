# udp=server.py

from socket import socket, AF_INET, SOCK_DGRAM

# SOCK_DGRAM : Socket Datagram (UDP)
with socket(AF_INET, SOCK_DGRAM ) as socket:
    server_addr = ("localhost", 5000)
    socket.bind(server_addr)
    # réception des données (max 1024 bytes), depuis une adresse
    nb = 1
    total = 0
    while nb != 0:
        data, client_addr = socket.recvfrom(1024)
        nb = data.decode()
        nb = int(nb)
        total += nb
    # on renvoie ces données au client
    total = str(total)
    data = total.encode()
    socket.sendto(data, client_addr)