#!/bin/bash

interne="Programmation des systemes"

if  [[ -v publique ]]; then
	if [[ ! -z "$publique" ]]; then
		echo "${interne}${publique}"
	else
		echo "La variable est vide" >&2
		exit 2
	fi
else
	echo "La variable n'existe pas" >&2
	exit 1
fi
