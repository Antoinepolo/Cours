<#
Objectif

Manipuler des paramètres passés au script de manière plus avancée.

Enoncé

Créer un script intitulé art.ps1 qui vise à tracer un carré du symbole “#” dont chaque côté a une longueur spécifiée par le paramètre “-Longueur”. La valeur de ce paramètre doit être spécifiée, positive et être au maximum égale à 20. Par exemple:

.\art.ps1 -Longueur 3
###
###
###
Affinement 1

Le paramètre “-Symbole” permet de spécifier le caractère qui sera utilisé. Si aucun caractère n’est fourni, “#” sera utilisé par défaut. Par exemple:

.\art.ps1 -Longueur 5 -Symbole '$'
$$$$$
$$$$$
$$$$$
$$$$$
$$$$$
Affinement 2

Le paramètre “-Forme” ne prend que deux valeurs possibles: “carre” (valeur par défaut) ou “rectangle”. Chaque valeur modifie la disposition du motif représenté. Si un rectangle est sélectionné, un autre paramètre “-Largeur” doit être défini (qui doit, comme “-Longueur”, se situer entre 1 et 20 compris). Par exemple:

.\art.ps1 -Longueur 5 -Symbole '$' -Forme rectangle -Largeur 3
$$$$$
$$$$$
$$$$$
Affinement 3

Le paramètre “-Hasard”, lorsqu’il est présent, fait en sorte que le symbole soit tiré au sort parmi un ensemble composé de toutes les lettres de l’alphabet ainsi que les chiffres. Ce tirage au sort a lieu pour chaque symbole affiché. Par exemple:

.\art.ps1 -Longueur 12 -Largeur 4 -Forme 'rectangle' -Hasard
89AGXQWB1W9D
XUT1HFK9M2B9
4DKENG9SYEQP
4MI7JBP6786Z
Affinement 4

Le paramètre “-Couleur”, lorsqu’il est présent, affiche en vert les symboles fournis par la chaîne de caractères accompagnant le paramètre “-Comparaison” et en rouge les autres. Si “-Couleur” est rensigné mais non “-Comparaison”, l’analyse se fera par rapport à la chaîne “POWERSHELL” par défaut. A noter que “-Couleur” n’a de sens que si le paramètre “-Hasard” a été défini également. Dès lors, “-Couleur” rend automatiquement “-Hasard” actif. Par exemple:

.\art.ps1 -Longueur 4 -Couleur
NRQK
4YHU
6MLG
TG19
Les lettres “R”, “H” et “L” sont en vert, les autres en rouge.

.\art.ps1 -Longueur 4 -Couleur -Comparaison 'bash'
8S74
ITDW
KVYC
ARPD
Les lettres “S” et “A” sont en vert, les autres en rouge.
#>

# Liste des paramètres 
param (
    [Parameter(Mandatory=$true)]
    [ValidateRange(1, 20)]
    [int]$Longueur,

    [ValidateRange(1, 20)]
    [int]$Largeur,
    
    [ValidateSet("carre", "rectangle")]
    [String]$Forme="carre",

    [String]$Symbole="#",

    [Switch]$Hasard,

    [switch]$Couleur,

    [string]$Comparaison = "POWERSHELL"
)

# Si la variable largeur n'est pas initialiser et qu'on est en mode rectangle, on sort du programme
if (($Forme -eq "rectangle") -and (-not $Largeur)) {
    Write-Error "La largeur n'a pas été trouvée"
    exit 1
}

# Si le paramètre couleur est là, on active le hasard
if ($Couleur) {
    $Hasard = $true
}

# Liste des caractères possibles
$Charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".ToCharArray()

# Fonction pour afficher une ligne avec les couleurs
function Write-ColorLine {
    param(
        [int]$Largeur,
        [string]$Comparaison,
        [array]$Charset
    )

    # On boucle sur la largeur de la ligne
    for ($j = 0; $j -lt $Largeur; $j++) {
        
        # On récupère un caractère au hasard
        $symbole = Get-Random -InputObject $Charset

        # Si le symbole est dans la chaine de comparaison, on l'affiche en vert, sinon en rouge
        if ($Comparaison.Contains($symbole)) {
            Write-Host $symbole -ForegroundColor Green -NoNewline
        } else {
            Write-Host $symbole -ForegroundColor Red -NoNewline
        }
    }

    # On créer une nouvelle ligne
    Write-Host ""
}

if ($Forme -eq "carre") {
    for ($i = 0; $i -lt $Longueur; $i++) {
        # On créer une variable pour la partie hasard
        # $ligne = ""
        # Si on a demander l'option hasard
        if ($Hasard) {

            # ===============================
            # On fait une deuxième boucle
            # for ($j = 0; $j -lt $Longueur; $j++) {
            #    $symbole = Get-Random -InputObject $charset
            #    $ligne += $symbole
            # }
            # On affiche 
            # Write-Output $ligne
            # ===============================

            # On affiche la ligne avec les bonnes couleurs
            Write-ColorLine -Largeur $Longueur -Comparaison $Comparaison -Charset $Charset
        } else {
            # Si on est pas en mode hasard, on affiche le symbole
            Write-Output ($Symbole * $Longueur)
        }
    }
} else {
    for ($i = 0; $i -lt $Longueur; $i++) {
        # On créer une variable pour la partie hasard
        # $ligne = ""
        # Si on a demander l'option hasard
        if ($Hasard) {

            # ===============================
            # On fait une deuxième boucle
            # for ($j = 0; $j -lt $Largeur; $j++) {
            #     $symbole = Get-Random -InputObject $charset
            #     $ligne += $symbole
            # }
            # On affiche 
            # Write-Output $ligne
            # ===============================

            # On affiche la ligne avec les bonnes couleurs
            Write-ColorLine -Largeur $Largeur -Comparaison $Comparaison -Charset $Charset
        } else {
            # Si on est pas en mode hasard, on affiche le symbole
            Write-Output ($Symbole * $Largeur)
        }
    }
}