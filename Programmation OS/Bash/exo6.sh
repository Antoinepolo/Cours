#!/bin/bash

# Ex 6 - Créer des comptes utilisateur sur base d’un fichier

# Base

# Réaliser un script qui permet de créer des comptes utilisateurs à partir d’un fichier comprenant login et mot de passe, séparés par des points virgules.

# Options

# Le script doit accepter les options suivantes:

# -h permet d’afficher une aide indiquant l’ordre dans lequel les éléments doivent être présent dans le fichier.
# -s separator permet de définir le séparateur (; étant le séparateur par défaut). L’option -s permet de choisir un autre séparateur.
# -l logfile permet de définir un fichier de log reprenant la date d’exécution du script et l’ensemble des commandes effectuées pour la création des comptes utilisateurs. Si le fichier existe, les informations sont à ajouter à la suite du fichier.
# -L error_logfile permet de définir un fichier de log qui reprendra la date d’exécution et les erreurs rencontrées.

# De base, on définit le séparateur sur : (dans le consigne on demane ;, mais dans le fichier on a des :)
separateur=":"

while getopts "hs:l:L:" options; do
        case "${options}" in
                h)
                        echo "Utilisation du fichier : login:password"
                        ;;
                s)
                        separateur="${OPTARG}"
                        ;;
                l)
                        logfile="${OPTARG}"
                        ;;
                L)
                        errorLogfile="${OPTARG}"
                        ;;
                *)
                        exit 1
                        ;;
        esac
done

# Si on a donner un logfile; on y inscrit le début de l'exécution
if [ -n "$logfile" ]; then
    echo "--- Début exécution le $(date '+%d/%m/%Y à %H:%M:%S') ---" >> "$logfile"
fi

# Si on a donner un errorLogfile; on y inscrit le début de l'exécution
if [ -n "$errorLogfile" ]; then
    echo "--- Début exécution le $(date '+%d/%m/%Y à %H:%M:%S') ---" >> "$errorLogfile"
fi

# On parcour les lignes de notre fichier
while read -r ligne; do
	# On récupère les deux parties de la ligne, le login et le password à l'aide de la commande cut
    login=$(echo "$ligne" | cut -d"$separateur" -f1)
    password=$(echo "$ligne" | cut -d"$separateur" -f2)

	# Si on a donner un errorLogfile (- L) alors on ajoute les erreurs dans le fichier
	if [ -n "$errorLogfile" ]; then
		# On ajoute le -m pour lui créer un /home
    	useradd -m "$login" 2>> "$errorLogfile"

    	# On ne peut pas utiliser passwd car elle est intéractive
		# NOTES : Le >&2, c'est pour rediriger vers le terminal stderr, pas un fichier
    	echo "$login:$password" | chpasswd 2>> "$errorLogfile"
	# Si on a pas préciser d'errorLogfile, alors on ajoute juste
	else
		# On ajoute le -m pour lui créer un /home
    	useradd -m "$login"

    	# On ne peut pas utiliser passwd car elle est intéractive
    	echo "$login:$password" | chpasswd
	fi

    # Si l'utilisateur à passer un logfile, on écrit dedans
    if [ -n "$logfile" ]; then
        echo "Création de l'utilisateur $login" >> "$logfile"
    fi

done < "passfile"

# Ca pose soucis le fait qu'on aie pas de vérification que les commandes soient bien exécutée ?
