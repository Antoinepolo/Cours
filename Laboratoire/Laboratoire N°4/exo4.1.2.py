# client.py
from socket import socket, AF_INET, SOCK_STREAM

with socket(AF_INET, SOCK_STREAM) as socket:
    socket.connect(("localhost" ,5000)) # connexion à un tuple IP/port
    data = input("Entrez votre message : ")
    socket.send(data.encode())
    data = socket.recv(1024)
    print("Received from server :", data.decode())
