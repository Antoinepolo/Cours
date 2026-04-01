<#
Objectifs

Manipuler une variable et sa portée.
Manipuler une structure conditionnelle (“if” et “switch”).
Enoncé

Déclarer une variable intitulée “temperature” au niveau de la console et lui attribuer une valeur entière, positive ou négative.

Réaliser un script qui affiche le message “La température introduite est:” suivi de la valeur de cette variable “temperature”. Ensuite un autre message est affiché, différent selon la valeur :

A partir de 30 ou plus: “Maillot et coups de soleil”
De 20 à 29: “Tee-shirt et sandales”
De 10 à 19: “Pull et chaussures”
De 0 à 9: “Doudoune et bottines”
A partir de -1 ou moins: “Double doudoune et après-skis”
Affinements

Afficher uniquement le message “Aucune température détectée” si la variable “temperature” n’existe pas ou ne comporte pas une valeur entière.

Ajouter de nouveaux messages à afficher qui se cumuleront entre eux et avec les précédents, selon la classification suivante:

Entre 1 et 7: “Un temps d’hiver”
Entre 6 et 15: “Un temps de printemps”
Entre 13 et 23: “Un temps d’été”
Entre 8 et 15: “Un temps d’automne”
Par exemple, si la température introduite est 15, voici ce qui devrait apparaître à l’écran:

La température introduite est: 15
Pull et chaussures
Un temps de printemps
Un temps d'été
Un temps d'automne
Trouver comment empêcher la variable “temperature” d’être récupérée dans le script (alors qu’elle a été déclarée dans la console). Ainsi, depuis la console, on pourra en afficher le contenu, mais le script retournera le message “Aucune température détectée”.

Parvenir à écrire le script en faisant uniquement usage de la syntaxe “If” (sans “Switch”) d’une part, ainsi que la syntaxe “Switch” (sans “If”) d’autre part.
#>

# $temperature = 

if (-not $temperature) {
    Write-Error "La variable n'a pas été trouvée"
    exit 1
}

if ($temperature -isnot [int]) {
    Write-Error "La température doit être un entier"
    exit 1
}

Write-Output “La température introduite est: $temperature”

if ($temperature -ge 30) {
    Write-Output “Maillot et coups de soleil”
} elseif ($temperature -ge 20) {
    Write-Output "Tee-shirt et sandales"
} elseif ($temperature -ge 10) {
    Write-Output “Pull et chaussures”
} elseif ($temperature -ge 0) {
    Write-Output “Doudoune et bottines”
} else {
    Write-Output “Double doudoune et après-skis”
}

if ($temperature -ge 1 -and $temperature -le 7) {
    Write-Output “Un temps d’hiver”
}

if ($temperature -ge 6 -and $temperature -le 15) {
    Write-Output “Un temps de printemps”
}

if ($temperature -ge 13 -and $temperature -le 23) {
    Write-Output “Un temps d’été”
}

if ($temperature -ge 8 -and $temperature -le 15) {
    Write-Output “Un temps d’automne”
}

# Remove-Variable -Name "temperature" 
# $private:temperature = 20

switch ($true) {
    (-not $temperature) {
        Write-Output "La variable n'a pas été trouvée"
        exit 1
    }
    ($temperature -isnot [int]) {
        Write-Output "La température doit être un entier"
        exit 1
    }
    ($temperature -ge 30) {
        Write-Output “Maillot et coups de soleil”
    }
    ($temperature -ge 20 -and $temperature -lt 30) {
        Write-Output "Tee-shirt et sandales"
    }
    ($temperature -ge 10  -and $temperature -lt 20) {
        Write-Output “Pull et chaussures”
    }
    ($temperature -ge 0  -and $temperature -lt 10) {
        Write-Output “Doudoune et bottines”
    }
    ($temperature -lt 0) {
        Write-Output “Double doudoune et après-skis”
    }
    ($temperature -ge 1 -and $temperature -le 7) {
        Write-Output “Un temps d’hiver”
    }
    ($temperature -ge 6 -and $temperature -le 15) {
        Write-Output “Un temps de printemps”
    }
    ($temperature -ge 13 -and $temperature -le 23) {
        Write-Output “Un temps d’été”
    }
    ($temperature -ge 8 -and $temperature -le 15) {
        Write-Output “Un temps d’automne”
    }
}