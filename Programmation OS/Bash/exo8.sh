# Configuration backup
# 
# Étape 1
# 
# Écrire une fonction check_compat répondant aux spécifications suivantes:
# 
# la fonction accepte exactement deux paramètres:
# le premier paramètre est un chemin vers un fichier d’archive de format .tar,
# le second paramètre est un chemin vers un fichier de l’arborescence.
# la fonction teste si l’archive contient un fichier dont le nom est identique à celui du fichier passé en paramètre. Cette dernière retourne un statut de sortie égal à 0 si aucun conflit n’est détecté et égal à 1 sinon.
# Étape 2
# 
# Écrire une fonction backup_files répondant aux spécifications suivantes:
# 
# La fonction accepte exactement trois paramètres:
# le premier paramètre est un chemin vers un fichier d’archive de format .tar qui, s’il n’existe pas, sera créé par la fonction,
# le second paramètre est un chemin vers un fichier régulier index qui contiendra la liste des fichiers effectivement contenu dans l’archive,
# le troisième paramètre est un chemin vers un fichier régulier liste. Chaque ligne de ce fichier identifie un fichier à ajouter à l’archive.
# Pour chacun des fichiers contenus dans liste la fonction teste l’existence du fichier dans l’arborescence, vérifie les droits (lecture à minima), ajoute ce fichier à la racine de l’archive et ajoute son chemin absolu dans l’arborescence dans le fichier index.
# L’ensemble des fichiers qui n’ont pas pu être ajoutés à l’archive sont affichés par la fonction sur la sortie d’erreur.
# La fonction retourne un statut de sortie égal à 0 si tous les fichiers ont pu être ajoutés à l’archive, 1 si certains fichier n’ont pas pu être ajoutés et 2 si le processing du fichier # liste a été interrompu par une erreur de traitement (comprendre ici que tous les retours de commandes doivent être testés, une erreur interrompant le traitement).
# Étape 3

# Écrire une fonction restore_file répondant aux spécifications suivantes:

# la fonction accepte comme unique paramètre un chemin vers une archive de format .tar.
# La fonction extrait dans un premier temps le fichier .index_list contenant les chemins de destination de tous les fichiers de l’archive.
# pour chacun des fichiers identifiés dans le fichier .index_list, la fonction extrait le fichier correspondant de l’archive et le déplace à l’endroit spécifié dans le fichier .index_list. Si le répertoire n’existe pas, ce dernier est créé.
# En cas d’erreur lors du déploiement du fichier, le nom du fichier est son chemin de destination sont affichés sur la sortie d’erreur du script.
# La fonction retourne un statut de sortie égal à 0 si tous les fichiers ont pu être déployés, 1 si certains fichier n’ont pas pu être déployés et 2 si le traitement a été interrompu par # une erreur.
# Étape 4
# 
# Écrire un script backup_manager qui respecte le synopsys suivant:
# 
# backup_manager [-c file1[,file2[,file3[,...]]]] [-h] [-i index_file] [-L logfile] archive
# 
# archive est le chemin de l’archive à traiter,
# -h: affiche l’aide de la commande
# -c file1[,file2[,file3[,...]]]: si cette option est fournie, l’archive archive doit être créé (elle ne doit pas exister préalablement) et doit contenir à la fin du traitement        l’ensemble des fichiers contenus dans les fichiers file1, file2, …
# -L logfile: les erreurs sont ajoutées au fichier logfile plutôt qu’être affichées sur la sortie standard.
# -i index_file: spécifie le nom du fichier d’index de l’archive. Par défaut ce dernier vaut .index_list. Attention à bien modifier les fonctions en conséquence.
# L’action par défaut est le déploiement des fichiers contenus dans archive. Cette action est modifiée par l’option -c.



#!/bin/bash

index_file=".index_list"
logfile="/dev/stderr"
mode="restore"
listes_fichiers=""

# Boucle sur les options
while getopts "c:hi:L:" opt; do
    case $opt in
        c)
            mode="backup"
            listes_fichiers=$OPTARG
            ;;
        h)
            echo "Usage: $0 [-c file1,file2,...] [-h] [-i index_file] [-L logfile] archive"
            exit 0
            ;;
        i)
            index_file=$OPTARG
            ;;
        L)
            logfile=$OPTARG
            ;;
        *)
            exit 1
            ;;
    esac
done

# Étape 1
# 
# Écrire une fonction check_compat répondant aux spécifications suivantes:
# 
# la fonction accepte exactement deux paramètres:
# le premier paramètre est un chemin vers un fichier d’archive de format .tar,
# le second paramètre est un chemin vers un fichier de l’arborescence.
# la fonction teste si l’archive contient un fichier dont le nom est identique à celui du fichier passé en paramètre. Cette dernière retourne un statut de sortie égal à 0 si aucun conflit n’est détecté et égal à 1 sinon.

check_compat () {
    local tar_path="${1}"
    local file_path="${2}"

    # On extrait uniquement le nom du fichier (sans l'extention), pour ce faire, on utilise basename qui permet de retirer le reste du chemin (/home/antoine/test.txt -> text.txt), ensuite on doit encore retirer l'extention, pour ça, on peut enlever la dernière partie avec ${var%.*}
    local nom_file_path=$(basename "$file_path")
    nom_file_path="${nom_file_path%.*}"

    # Ensuite, on peut boucler sur tout les fichiers de l'archives (tar -tf pour de lister les fichiers)
    for fic in $(tar -tf "$tar_path"); do
        # On refait comme au dessus, mais cette fois ci, pour le nom du fichier dans le tar
        local nom_fic=$(basename "$fic")
        nom_fic="${nom_fic%.*}"

        # Si on trouve une correspondance, on return 1
        if [[ "$nom_file_path" == "$nom_fic" ]]; then
            return 1
        fi
    done

    # Si on ne trouve aucune correspondance, on return 0
    return 0
}

# Étape 2
# 
# Écrire une fonction backup_files répondant aux spécifications suivantes:
# 
# La fonction accepte exactement trois paramètres:
# le premier paramètre est un chemin vers un fichier d’archive de format .tar qui, s’il n’existe pas, sera créé par la fonction,
# le second paramètre est un chemin vers un fichier régulier index qui contiendra la liste des fichiers effectivement contenu dans l’archive,
# le troisième paramètre est un chemin vers un fichier régulier liste. Chaque ligne de ce fichier identifie un fichier à ajouter à l’archive.
# Pour chacun des fichiers contenus dans liste la fonction teste l’existence du fichier dans l’arborescence, vérifie les droits (lecture à minima), ajoute ce fichier à la racine de l’archive et ajoute son chemin absolu dans l’arborescence dans le fichier index.
# L’ensemble des fichiers qui n’ont pas pu être ajoutés à l’archive sont affichés par la fonction sur la sortie d’erreur.
# La fonction retourne un statut de sortie égal à 0 si tous les fichiers ont pu être ajoutés à l’archive, 1 si certains fichier n’ont pas pu être ajoutés et 2 si le processing du fichier liste a été interrompu par une erreur de traitement (comprendre ici que tous les retours de commandes doivent être testés, une erreur interrompant le traitement).

backup_files () {
    local tar_path="${1}"
    local index_path="${2}"
    local list_path="${3}"

    # Variable pour stocker les erreurs
    local erreur=0

    # On vérifie si on peut lire le fichier, si non, on retourne pas
    if [[ ! -r "$list_path" ]]; then
        echo "Erreur : impossible de lire le fichier liste $list_path" >&2
        return 2
    fi

    # On créer (ou vide si il existe) le fichier d'index
    > "$index_path" || return 2

    # On lit le fichier de liste ligne par ligne
    while read -r file; do

        # On vérifie que le fichier existe, et qu'on a les permissions dessus
        if [[ -f "$file" && -r "$file" ]]; then
        
            # On ajoute le fichier à l'archive, si cette dernière n'existe pas, on la créer (-c)
            if [[ ! -f "$tar_path" ]]; then
                tar -cf "$tar_path" -C "$(dirname "$file")" "$(basename "$file")"
            else
                tar -rf "$tar_path" -C "$(dirname "$file")" "$(basename "$file")"
            fi

            # On vérifie que la commande n'a pas retourner d'erreur
            if [[ $? -ne 0 ]]; then
                echo "Erreur lors de l'archivage du fichier" >&2
                return 2
            fi

            # On ajoute le chemin complet au fichier d'index
            realpath "$file" >> "$index_path"

        # Si on a pas trouver le fichier ou qu'on n'a pas asser de permission
        else

            echo "Impossible de lire/trouver le ficier $file" >&2
            erreur=1
        fi

    done < "$list_path"

    # ON AJOUTE L'INDEX DANS LE TAR (Sinon restore_file ne trouvera rien)
    tar -rf "$tar_path" "$index_path" 2>/dev/null

    # On retourne le code d'erreur (si un fichier n'a pas pu être lu)
    return "$erreur"
}

# Étape 3

# Écrire une fonction restore_file répondant aux spécifications suivantes:

# la fonction accepte comme unique paramètre un chemin vers une archive de format .tar.
# La fonction extrait dans un premier temps le fichier .index_list contenant les chemins de destination de tous les fichiers de l’archive.
# pour chacun des fichiers identifiés dans le fichier .index_list, la fonction extrait le fichier correspondant de l’archive et le déplace à l’endroit spécifié dans le fichier .index_list. Si le répertoire n’existe pas, ce dernier est créé.
# En cas d’erreur lors du déploiement du fichier, le nom du fichier est son chemin de destination sont affichés sur la sortie d’erreur du script.
# La fonction retourne un statut de sortie égal à 0 si tous les fichiers ont pu être déployés, 1 si certains fichier n’ont pas pu être déployés et 2 si le traitement a été interrompu par # une erreur.

restore_file () {
    local tar_path="${1}"
    local idx_name="${2}"

    # On uniquement le .index_list
    tar -xf "$tar_path" "$idx_name" 2>/dev/null

    # On lit le fichier .index_list ligne par ligne avec read
    while read chemin; do

        # On récupère le nom du fichier
        nom=$(basename "$chemin")
        
        # On récupère le dossier de destination
        destination=$(dirname "$chemin")

        # On crée le dossier s'il n'existe pas
        mkdir -p "$destination"

        # On extrait le fichier à plat là où on est
        tar -xf "$tar_path" "$nom" 2>/dev/null

        # On le déplace vers son chemin absolu
        if [[ -f "$nom" ]]; then
            mv "$nom" "$chemin"
        else
            echo "$nom $chemin" >&2
        fi

    done < "$idx_name"
}

# Étape 4

# On fait un décalage sur les paramètres pour ne récupérer que les paramètres
shift $((OPTIND-1))
archive=$1

# On vérifie qu'on a bien donner le nom de l'archive
if [[ -z "$archive" ]]; then
    echo "Erreur : Chemin de l'archive manquant." >&2
    exit 2
fi

# Si on est en mode backup
if [[ "$mode" == "backup" ]]; then
    # Si le fichier d'archive existe
    if [[ -e "$archive" ]]; then
        # On met un message d'erreur pour dire qu'on ne peut pas le créer car il existe
        echo "Le fichier d'archive '$archive' existe déjà." >> "$logfile"
        exit 1
    fi

    status=0

    # On boucle sur les fichier de la liste avec un read pour gérer les virgules
    while read f_liste; do
        if [[ -n "$f_liste" ]]; then
            # On utilise notre fonction pour backup les fichiers
            backup_files "$archive" "$index_file" "$f_liste" 2>> "$logfile"
            res=$?
            
            if [[ $res -eq 2 ]]; then exit 2; fi
            if [[ $res -eq 1 ]]; then status=1; fi
        fi
    done < <(echo "$listes_fichiers" | tr ',' '\n')
    
    # On retourne avec une erreur du status
    exit $status

else
    # Si on est en mode restore
    if [[ ! -f "$archive" ]]; then
        # On affiche un message d'erreur
        echo "Archive '$archive' introuvable." >> "$logfile"
        exit 2
    fi
    
    # On appelle la fonction pour lancer la restauration
    restore_file "$archive" "$index_file" 2>> "$logfile"
    exit $?
fi
