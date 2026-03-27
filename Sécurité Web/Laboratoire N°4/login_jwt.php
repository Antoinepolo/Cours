<?php
// On Charge l'autoloader, ça évite d'inclure tout les fichiers à la main
require 'vendor/autoload.php';

// On indique des racourcis de classes et import des classes pour le JWT
use Root\Html\Connection;
use Dotenv\Dotenv;
use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

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
$username = $_POST['username'] ?? null;
$password = $_POST['password'] ?? null; 

// On créer une nouvelle session avec un ID ou la recharger si elle existe

try {
    // On prépare la requête
    $sql = "SELECT nom, prenom, password FROM users WHERE nom = :username";
    // On prépare l'envoie à la base donnée
    $stmt = $pdo->prepare($sql);

    // On exécute la requête
    $stmt->execute([':username' => $username]);

    // On récupère la ligne correspondante
    $user = $stmt->fetch(); // Récupère la première ligne correspondante

    // Si on a un utilisateur
    if ($user) {
        // Si le mot de passe est bon
        if (password_verify($password, $user['password'])) {

            // On créer le contenu du JWT sous la forme d'un dictionnaire
            $token = [
                "iat" => time(),                    // Moment de la création
                "exp" => time() + 3600,             // Moment de l'expiration (dans une heure)
                "data" => [
                    "username" => $user['nom'],     // Quel utilisateur ?
                    "loggedIn" => true              // Il y a maintenant une session active
                ]
            ];

            // On chiffre le JWT en HS256
            $secret_key = "7b9f2e4a8c1d5b3f0e2a4d6c8b0a1f3e";
            
            echo "test1";
            $jwt = JWT::encode($token, $secret_key, 'HS256');
            echo "test2";

            // On envoie le JWT dans un cookie
            setcookie("jwt", $jwt, httponly:true);

            // On redirige l'utilisateur vers home.php
            header('Location: home.php');

            // On termine le script de login
            exit();
        } else {
            // Sinon (mot de passe incorrect), on affiche une erreur
            echo "Mot de passe incorrect";
        }
    } else {
        // Si aucun utilisateur n'a été trouver, on l'indique
        echo "Utilisateur non enregistré.";
    }

} catch (PDOException $e) {
    echo "Erreur : " . $e->getMessage();
}
?>
