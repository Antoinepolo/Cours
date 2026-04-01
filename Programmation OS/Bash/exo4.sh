#!/bin/bash

fichier="./passwd"
debut=1000
fin=65535
nb_id=-1
consecutif=0

# Case sur les options
while getopts "f:m:M:uhn:c" options; do
        case "${options}" in
                f)
                        fichier="${OPTARG}"
                        ;;
                m)
                        debut="${OPTARG}"
                        ;;
                M)
                        fin="${OPTARG}"
                        ;;
                u)
                        debut=1000
                        ;;
                h)
                        echo "./exo4.sh ..."
                        exit 0
                        ;;
                n)
                        nb_id="${OPTARG}"
                        ;;
                c)
                        consecutif=1
                        ;;
                *)
                        exit 1
                        ;;
        esac
done

# On regarde si le fichier existe
if [[ ! -f  "$fichier" ]]; then
        echo "Le fichier est introuvable"
        exit 2
fi

# On regarde si on a les permissions sur le fichier
if [[ ! -r "$fichier" ]]; then
        echo "Permission inssufisante sur le fichier"
        exit 2
fi

# On regarde si l'uid est un nombre positif
if [[ "$debut" -lt 0 ]]; then
        echo "L'UID doit etre un nombre positif"
        exit 3
fi

# On vérifie si le début est un nombre positif
if [[ "$debut" -lt 0 ]]; then
        echo "Le debut doit etre un nombre positif"
        exit 3
fi

# On vérifie si le fin est positive
if [[ "$fin" -lt 0 ]]; then
        echo "La fin doit etre un nombre positif"
        exit 3
fi

# On vérifie si le fin est plus grande que le debut
if [[ "$fin" -lt "$debut" ]]; then
        echo "La fin doit etre plus grande que le debut"
        exit 3
fi

# On vérifie si le fin est plus grande que le debut
if [[ "$nb_id" -lt 0 ]]; then
        echo "Le nombre d'uid a afficher doit etre supperieure a 0"
        exit 3
fi

# Si on ne veut pas le -c
if [[ "$consecutif" == 0 ]]; then
        # Variable pour stocker le nombre d'UID affiché (pour -n)
        j=0

        # On boucle sur le tout
        for i in $(seq "$debut" "$fin"); do
                # Si l'uid n'est pas trouvée dans le fichier
                if ! grep -q ":x:$i:" "$fichier"; then
                        # On l'affiche
                        echo "Le prochain UID disponible est : $i"
                        # On incrémente le compteur pour -n
                        (( j++ ))
                fi

                # Si on atteint la limite, on sort
                if [[ "$j" == "$nb_id" ]] && [[ "$nb_id" != -1 ]]; then
                        exit 0
                fi
        done

        exit 0
else
# Si on veut le -c

        # Si on veut des nombres consécutifs
        # Variable pour stocker le nombre d'UID affiché (pour -n)
        j=0

        # Variable qui stocke l'ancien UID pour savoir si c'est consecutif 
        ancien_uid=-1

        # On boucle depuis le début jusqu'à la fin
        for i in $(seq "$debut" "$fin"); do
                # Si on ne trouve pas l'UID (il est donc dispo)
                if ! grep -q ":x:$i:" "$fichier"; then
                        # On vérifie que l'ancien uid est soit -1 soit le dernier uid, si oui, on affiche
                        if [[ "$ancien_uid" -eq -1 ]] || [[ $((ancien_uid + 1)) -eq "$i" ]]; then
                                # On affiche et on incrémente la variable pour le -n
                                echo "Le prochain UID disponible est : $i"
                                (( j++ ))
                                # On set l'ancien uid à l'uid actuel
                                ancien_uid="$i"
                        fi
                fi

                # Si on tombe sur la limite de -n, on sort
                if [[ "$j" == "$nb_id" ]] && [[ "$nb_id" != -1 ]]; then
                        exit 0
                fi
        done

        exit 0
fi
