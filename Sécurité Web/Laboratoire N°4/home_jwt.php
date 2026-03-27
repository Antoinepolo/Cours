<?php
// On Charge l'autoloader, ça évite d'inclure tout les fichiers à la main
require 'vendor/autoload.php';

// On importe des classes pour le JWT
use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;
use \Firebase\JWT\SignatureInvalidException;

// On reprend la clé du login.php
$secret_key = "7b9f2e4a8c1d5b3f0e2a4d6c8b0a1f3e";

// On vérifie que le cookie existe bien
if (isset($_COOKIE["jwt"])) {
	// On le stocke dans une variable
    $jwt = $_COOKIE["jwt"];

    try {
        // On décode le token
        $decoded = JWT::decode($jwt, new Key($secret_key, 'HS256'));
	} catch(SignatureInvalidException $e) {
		exit();
	}

    // On récupère les données
    $username = $decoded->data->username;
    $loggedIn = $decoded->data->loggedIn;

    // On vérifie si l'utilisateur est bien marqué comme connecté
    if ($loggedIn) {
        echo "Welcome " . $username;
    } else {
        header("Location: login.html");
        exit();
    }
} else {
	header("Location: login.html");
	exit();
}
?>
