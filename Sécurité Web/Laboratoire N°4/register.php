<?php
// On Charge l'autoloader, ça évite d'inclure tout les fichiers à la main
require 'vendor/autoload.php';

// On indique des racourcis de classes
use Root\Html\Connection;
use Dotenv\Dotenv;

// On initialise le fichier .env qui contient les credentials de connexion à la DB, ça évite des les mettres en clair dans le programme
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

// On se connecte à la base de donnée
$pdo = Connection::make(
    $_ENV['DATABASE_HOST'],
    $_ENV['DATABASE_NAME'],
    $_ENV['DATABASE_USER'],
    $_ENV['DATABASE_PASSWORD']
);

// Variable récupérée dans le formulaire
$nom = $_POST['nom'] ?? null;
$prenom = $_POST['prenom'] ?? null;
$password = $_POST['password'] ?? null; 

// On vérifie bien que tous les champs soient remplit
if ($nom && $prenom && $password) {
    try {
        // On prépare la requête
        $sql = "INSERT INTO users(nom, prenom, password) VALUES (:nom, :prenom, :hashed_password)";
        // On prépare l'envoie à la base donnée
        $stmt = $pdo->prepare($sql);

        // On hash le mot de passe (PASSWORD_DEFAULT = meilleur algo du moment), et on le stocke dans une variable
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // On exécute la requête (ici, on doit tout envoyer d'un comp)
        $stmt->execute([
            ':nom'             => $nom,
            ':prenom'          => $prenom,
            ':hashed_password' => $hashed_password
        ]);

        // On affiche un message pour dire que le compte a été créer avec succès
        echo "Compte créer avec succès";

    } catch (PDOException $e) {
        echo "Erreur : " . $e->getMessage();
    }
} else {
    // On demande a tout completer si un est manquant
    echo "Veuillez completer tout les champs";
}
?>
