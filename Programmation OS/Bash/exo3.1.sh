#!/bin/bash

#fichier="passwd"

if [[ "$#" -lt 2 ]]; then
	echo "Utilisation : ./exo3.1.sh <fichier> <debut>"
	exit 1
fi

fichier="$1"
debut="$2"

if [[ ! -f  "$fichier" ]]; then
	echo "Le fichier est introuvable"
	exit 2
fi

if [[ ! -r "$fichier" ]]; then
	echo "Permission inssufisante sur le fichier"
	exit 2
fi

if [[ "$debut" -le 0 ]]; then
	echo "L'UID doit etre un nombre pasitif"
	exit 3
fi

for i in $(seq "$debut" 65525); do
	if ! grep -q ":x:$i:" "$fichier"; then
        	echo "Le prochain UID disponible est : $i"
        	exit 0
    	fi
done
