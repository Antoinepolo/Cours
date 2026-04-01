#!/bin/bash

erreur=0

inconnu=0
robert=0
test=0
root=0

echo "Nombre de parametres: $#"

for param in "$@"; do
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
done

echo "Nombre de parametres robert : $robert"
echo "Nombre de parametres test : $test"
echo "Nombre de parametres root : $root"
echo "Nombre de parametres inconnu : $inconnu"

if [[ "$erreur" == 1 ]]; then
	exit 1
fi
