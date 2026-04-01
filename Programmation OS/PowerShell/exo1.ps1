<#
Préparation de l’environnement

Il est nécessaire au minimum de posséder sur votre machine de quoi exécuter PowerShell et écrire des fichiers contenant du texte brut.

Pour ce dernier point, tout éditeur fera l’affaire: nano, gedit, emacs, vim, sublime, visual studio, notepad,… Il est toutefois possible d’optimiser votre travail en choisissant un outil que vous maîtrisez déjà ou dans lequel vous souhaitez vous investir. La coloration syntaxique, l’auto-complétion, les snippets,… sont autant d’apports qui vous feront gagner du temps.

Concernant la disponibilité de powershell en vue d’exécuter vos futurs scripts, les choses changent selon la plateforme que vous utilisez (voire la famille de powershell que vous désirez employer).

Pour les utilisateurs d’un ordinateur tournant sous Windows, PowerShell 5.1 est déjà installé. Toutefois, cette branche n’a plus évolué depuis 2016 et n’évoluera probablement plus. Il vous est donc conseillé d’installer la version la plus récente de la nouvelle branche (open source), intitulée “PowerShell Core”, laquelle est activement soutenue.

Pour les utilisateurs d’un ordinateur tournant sous Linux ou Mac, vous devrez nécessairement installer “PowerShell Core”.

Quelle que soit votre plateforme, les explications visant l’installation de l’édition “PowerShell Core” se trouve sur la page https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell.

Hello World

Une fois votre environnement de travail fonctionnel, créez un premier script qui, une fois exécuté, affichera “Hello World”.

Manipulation d’objet

Comme expliqué durant le cours, l’une des différences fondamentales qu’il existe entre Bash et PowerShell est le fait que PowerShell soit orienté objet.

Ainsi, tout caractère ou toute chaine de caractères entré dans la console PowerShell est considéré comme un objet.

Sur base de l’affirmation précédente, créez une ligne de commande qui vous retourne le nombre de caractères contenu dans le string “PowerShell is powerful!”

Objet et processus

L’orienté objet permet de stocker le résultat d’une commande dans une variable. Une manière de démontrer la manipulation d’objet consiste à effectuer une action sur une variable qui contient un objet.

Ouvrez une fenêtre bloc-notes depuis la console PowerShell.

Récupérez les informations relatives au processus bloc-notes que vous avez exécuté et stockez-le dans une variable.

Utilisez la commande kill depuis la console PowerShell pour fermer le bloc-notes.

Alias

Tout comme Bash, PowerShell vous permet de créer vos propres alias. Les alias sont une chaine de caractères qui est définie par l’utilisateur et qui contient une commande (ou une suite de commandes) qui peuvent être exécutées depuis la console PowerShell.

Créez un alias “listd” qui vous permet de lister le contenu du répertoire dans lequel vous vous trouvez.
Créez un alias “ippub” qui affiche votre IP publique. Pour ce faire, vous pouvez récupérer le contenu d’une requête web vers le site ifconfig.me.
Découvertes de commandes

PowerShell vous permet d’utiliser les caractères wildcards lors de vos requêtes. Affichez toutes les commandes qui contiennent le mot service dans le nom de la commande.
#>

# cd "/Users/antoinepolo/Library/Mobile Documents/com~apple~CloudDocs/🎓 Cours/B2 - Q2/📚 Programmation orientée systèmes d’exploitation /Laboratoire/PowerShell"
# pwsh exo1.ps1

Write-Output "Hello Wolrd"

$string = "PowerShell is powerful!"
$nb_char = $string.Length
Write-Output $nb_char

# On ouvre l'application (macOS)
open -a TextEdit

# On capture l'objet
$monProcess = Get-Process TextEdit

Write-Output $monProcess

Stop-Process -InputObject $monProcess
# Ou : $monProcess | Stop-Process

# Set-Alias listd Get-ChildItem
# function Get-MyIP { Invoke-RestMethod https://ifconfig.me/ip }; Set-Alias ippub Get-MyIP

Get-Command *Service* | Format-Table # On met ça pour formater le message et ne pas avoir une liste interminable
