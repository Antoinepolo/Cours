#!/bin/bash

i=1

erreur=0

inconnu=0
robert=0
test=0
root=0

echo "Nombre de parametres: $#"

while [[ $i -le $# ]]; do
	# Notes : On ne peut pas utiliser $i pour faire notre case dessus directement, car il
	# contient la valeur de i, donc 1, 2, 3

	# Ici on utilise le ! pour dire va lire ce qu'il y a dans $1 et pas dans $i (qui est un
	# nombre)
	param=${!i}

	case "$param" in
		"robert")
			echo "Bonjour Robert"
			(( robert++ ))
			;;
		"test")
			echo "Ceci est un compte test"
			(( test++ ))
			;;
		"root")
			echo "Bienvenue cher administrateur"
			(( root++ ))
			;;
		*)
			echo "Ce paramètre est inconnu"
			(( inconnu++ ))
			erreur=1
			;;
	esac

	(( i++ ))
done

echo "Nombre de parametres robert : $robert"
echo "Nombre de parametres test : $test"
echo "Nombre de parametres root : $root"
echo "Nombre de parametres inconnu : $inconnu"

if [[ "$erreur" == 1 ]]; then
	exit 1
fi
