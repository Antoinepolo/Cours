#!/bin/bash

# Base
# 
# Réaliser un script qui liste les comptes utilisateurs normaux du système, c’est à dire les utilisateurs dont le UID (3ème colonne dans le fichier /etc/passwd) est supérieur à 1000 (ou 500 selon la distribution).
#
# Shell
#
# Le script doit également indiquer le shell par défaut de l’utilisateur.
#
# Options
#
# Le script accepte l’option à argument -u user permettant d’afficher le shell par défaut de l’utilisateur user. Si l’utilisateur n’existe pas ou si ce dernier n’est pas un utilisateur normal (UID inférieur à 1000 ou 500 selon le cas), le script retourne différents codes d’erreur.

# On récupère les paramètres pour la suite de l'exo
user="user"

while getopts "u:" options; do
        case "${options}" in
                u)
                        user="${OPTARG}"
                        ;;
                *)
                        exit 1
                        ;;
        esac
done

echo "===== Première Partie ====="

# On boucle de 1001 jusqu'à la fin
for i in $(seq 1001 2000); do # Il faut remettre 65252 mais pour les tests, c'est trop lent

    # On créer une ligne qui contient le résultat d'un grep sur un UID = $i
    # On va cherhcer dans le ficher passwd (pas celui dans /etc)
    ligne=$(grep ":x:$i:" "passwd")

    # Si la ligne existe (si on a eu un retour)
    if [ -n "$ligne" ]; then

        # On récupère le nom, pour ce faire on découpe au : pour ne grader que le premier champ
        nom=$(echo "$ligne" | cut -d: -f1)

        # Ici, on récup le shell en cutant à la bonne partie (7ème champ)
        shell=$(echo "$ligne" | cut -d: -f7)

        # On affiche un message
        echo "L'UID $i est utilisé par l'utilisateur $nom et à pour shell : $shell"
	fi
done

echo "===== Deuxième Partie ====="

# On la ligne qui correspond à l'utilisateur
ligne=$(grep "${user}:" "passwd")

# Si le grep n'a rien renvoyer alors on affiche une erreur
if [ -z "$ligne" ]; then
        echo "L'utilisateur n'existe pas" >&2
        exit 3
fi

# On extrait l'UID et le Shell
uid=$(echo "$ligne" | cut -d: -f3)
shell=$(echo "$ligne" | cut -d: -f7)

# On regarde si l'UID est valable
if [[ "$uid" -le 1000 ]]; then
        echo "L'UID ne peut être inférieur ou égal à 1000" >&2
        exit 3
fi

echo "L'utilisateur $user à pour shell = $shell"
