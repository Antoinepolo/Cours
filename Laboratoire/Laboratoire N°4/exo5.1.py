# Serveur
from socket import socket, AF_INET, SOCK_STREAM
from sys import argv

# on crée un socket d’écoute
# AF_INET : Adress Family Internet (IP)

# SOCK_STREAM : Socket Stream (TCP)
with socket(AF_INET, SOCK_STREAM) as server_socket :
    # Ici on passe localhost et 5000
    server_addr = (argv[1], int(argv[2]))
    server_socket.bind(server_addr) # on le lie à un tuple ip/port
    server_socket.listen() # on le met en mode écoute

    # on attend une connexion => bloquant!
    # quand une connexion est reçue, un socket est créé pour communiquer et
    # l’addresse du client est récupérée
    try:
        while True:
            client_socket, client_address = server_socket.accept()

            with client_socket:
                # On met une deuxième boucle pour garder le socket (ne pas le fermer)
                # Et quand on reçoit un signal de fin (vide), alors on sort de la boucle
                # pour permettre d'accepter un second socket
                while True:
                    try:
                        # On reçoit le nom
                        # Si on ne reçoit pas de nom, c'est que le serveur à fermer la connexion
                        file_name_bytes = client_socket.recv(1024)
                        if not file_name_bytes:
                            break
                        file_name = file_name_bytes.decode()

                        # On reçoit les données
                        data = client_socket.recv(1024)

                        # On écrit dans le fichier
                        with open(file_name, "w") as file:
                            file.write(data.decode())

                        # On envoie un message pour dire que tout c'est bien passer
                        client_socket.send("Fichier créer avec succès".encode())
                    except Exception as e:
                        # Attention ici, e n'est pas un str, on doit donc le cast
                        client_socket.send(str(e).encode())

    except KeyboardInterrupt:
        print("Fin du programme")