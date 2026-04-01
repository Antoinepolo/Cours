<#
Objectifs

Manipuler des paramètres passés au script.
Manipuler une structure itérative (“For”, “While”, “Do”, “ForEach”).
Enoncé

Créer un script qui affiche le nombre de paramètres qui lui ont été passés. De plus, pour chaque paramètre, afficher un message personnalisé selon la valeur, à savoir:

Un paramètre robert engendrera le message “Bonjour Robert”.
Un paramètre test engendrera le message “Ceci est un compte test”.
Un paramètre admin engendrera le message “Bienvenue cher administrateur”.
Tout autre paramètre que ceux évoqués engendrera un message d’erreur “Ce paramètre est inconnu”.
Par exemple:

$ ./ex2.sh robert admin
Nombre de paramètres: 2
Bonjour Robert
Bienvenue cher Administrateur
Affinements

Affiner le nombre de paramètres de sorte que l’on puisse distinguer la fréquence de chacun (combien de fois apparaît robert, combien de fois apparaît test,…).

Prévoir des variantes du script, chacune faisant usage d’une structure itérative différente: for, while, do, foreach.
#>

# Il doit toujours se trouver en premier dans le programme, si il y a un Write-Output ou autre avant -> Erreur
param (
    # On active l'option "aspirateur"
    [Parameter(ValueFromRemainingArguments = $true)]
    # Liste ou on va tout mettre
    [string[]]$ListeParametres
)

$nb = $ListeParametres.Count
Write-Output "Nombre de paramètres: $nb"

$robert = 0
$test = 0
$admin = 0
$inconnu = 0

foreach ($Param in $ListeParametres) {
    switch ($Param.ToLower()) {
        "robert" {
            Write-Output "Bonjour Robert"
            $robert++
        }
        "test" {
            Write-Output "Ceci est un compte test"
            $test++
        }
        "admin" { 
            Write-Output "Bienvenue cher administrateur"
            $admin++
        }
        default {
            Write-Output “Ce paramètre est inconnu”
            $inconnu++
        }
    }
}

Write-Output "Robert : $robert, Test : $test, Admin : $admin, Inconnu : $inconnu"

Write-Output "===================="

$robert = 0
$test = 0
$admin = 0
$inconnu = 0

$i = 0 
while($i -lt $nb) {
    $Param = $ListeParametres[$i]
        switch ($Param.ToLower()) {
        "robert" {
            Write-Output "Bonjour Robert"
            $robert++
        }
        "test" {
            Write-Output "Ceci est un compte test"
            $test++
        }
        "admin" { 
            Write-Output "Bienvenue cher administrateur"
            $admin++
        }
        default {
            Write-Output “Ce paramètre est inconnu”
            $inconnu++
        }
    }
    $i++
}

Write-Output "Robert : $robert, Test : $test, Admin : $admin, Inconnu : $inconnu"

Write-Output "===================="

$robert = 0
$test = 0
$admin = 0
$inconnu = 0

$i = 0 

if ($nb -gt 0) {
    do {
        $Param = $ListeParametres[$i]
        switch ($Param.ToLower()) {
            "robert" {
                Write-Output "Bonjour Robert"
                $robert++
            }
            "test" {
                Write-Output "Ceci est un compte test"
                $test++
            }
            "admin" { 
                Write-Output "Bienvenue cher administrateur"
                $admin++
            }
            default {
                Write-Output “Ce paramètre est inconnu”
                $inconnu++
            }
        }
        $i++       
    } while ($i -lt $nb)
}

Write-Output "Robert : $robert, Test : $test, Admin : $admin, Inconnu : $inconnu"

Write-Output "===================="

$robert = 0
$test = 0
$admin = 0
$inconnu = 0

for ($i = 0; $i -lt $ListeParametres.Count; $i++) {
    $Param = $ListeParametres[$i]
        switch ($Param.ToLower()) {
        "robert" {
            Write-Output "Bonjour Robert"
            $robert++
        }
        "test" {
            Write-Output "Ceci est un compte test"
            $test++
        }
        "admin" { 
            Write-Output "Bienvenue cher administrateur"
            $admin++
        }
        default {
            Write-Output “Ce paramètre est inconnu”
            $inconnu++
        }
    }    
}

Write-Output "Robert : $robert, Test : $test, Admin : $admin, Inconnu : $inconnu"