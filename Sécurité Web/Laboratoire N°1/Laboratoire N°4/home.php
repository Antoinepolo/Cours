<?php
// On récupère les informations de la session
session_start();

// Si l'utilisateur essaie de directement accéder à la page, on le renvoie sur la page de login
if (!isset($_SESSION['prenom'])) {
    header('Location: login.html');
    exit();
}
?>

<html lang="fr">
	<body>
    	<p>Bienvenue, <?php echo $_SESSION['prenom']; ?></p>
	</body>
</html>
