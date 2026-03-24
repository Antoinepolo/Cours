import random
from random import randint
from socket import socket, AF_INET, SOCK_STREAM
from threading import Thread
from time import sleep


ids = ['Lion', 'Elephant', 'Tiger', 'Giraffe', 'Zebra', 'Kangaroo', 'Panda', 'Koala', 'Penguin', 'Cheetah']
texts = [
    "I told my computer I needed a break, and now it won’t stop sending me vacation ads.",
    "Why don’t skeletons fight each other? They don’t have the guts.",
    "I’m on a seafood diet. I see food and I eat it.",
    "I asked the librarian if the library had any books on paranoia. She whispered, 'They’re right behind you.'",
    "Parallel lines have so much in common. It’s a shame they’ll never meet.",
    "I’m writing a book on reverse psychology. Don’t buy it.",
    "I used to play piano by ear, but now I use my hands.",
    "I told my wife she was drawing her eyebrows too high. She looked surprised.",
    "I’m friends with all the electricians, but we don’t have any current connections.",
    "I have a lot of jokes about unemployed people, but none of them work."
]


def client(server_address):
    client_socket = socket(AF_INET, SOCK_STREAM)
    client_socket.connect(server_address)
    id = random.choice(ids)
    text = random.choice(texts)
    message = id + "#" + text
    client_socket.send(message.encode())
    client_socket.close()


server_address = ("127.0.0.1", 5000)

for i in range(10000):
    sleep(0.001)
    Thread(target=client,args=[server_address]).start()

