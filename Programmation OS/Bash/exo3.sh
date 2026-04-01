#!/bin/bash

status_code=0

if [[ "$#" == 0 ]]; then
	echo "Utilisation : ./exo3.sh <uid_1> <uid_2> ..."
	exit 1
fi

for uid in "$@"; do

	if [[ "$uid" -ge 1000 ]]; then
		echo "$uid : Utilisateur valide"
	else
		echo "$uid : Utilisateur invalide"
		status_code=1
	fi
done

if [[ "$status_code" == 1 ]]; then
	exit 1
fi
